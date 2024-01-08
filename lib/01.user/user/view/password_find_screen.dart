import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/layout/default_layout.dart';

import '../../../common/component/custom_text_style.dart';
import '../../../common/view/default_layout.dart';

class PasswordFindScreen extends StatefulWidget {
  const PasswordFindScreen({super.key});

  @override
  _PasswordFindScreenState createState() => _PasswordFindScreenState();
}

class _PasswordFindScreenState extends State<PasswordFindScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  bool isEmailValid = false;
  bool isCodeVerified = false;

  bool isButtonEnabled = false;

  bool isPasswordValid = false;

  String? serverCode;

  String? rightEmail;

  void isValidPassword(String password) {
    // 비밀번호가 8자 이상인지 확인
    if (newPasswordController.text.trim().length < 8) {
      isPasswordValid = false;
    }

    final password = newPasswordController.text.trim();

    // 영문, 숫자, 특수문자 포함 여부를 확인하기 위한 정규 표현식
    RegExp hasLetter = RegExp(r'[A-Za-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasSpecialCharacter = RegExp(r'[^A-Za-z0-9]');

    // 영문, 숫자, 특수문자가 각각 적어도 하나씩 포함되어 있는지 확인
    if (hasLetter.hasMatch(password) &&
        hasDigit.hasMatch(password) &&
        hasSpecialCharacter.hasMatch(password)) {
      isPasswordValid = true;
    }

    isPasswordValid = false;
  }


  // 이메일 유효성 검사 함수
  void _validateEmail(String value) {
    if (value.isNotEmpty && value.contains('@')) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }

  // 인증 코드 확인 및 새 비밀번호 입력 요청
  void _checkAuthCode() {
    // 사용자가 인증 코드를 입력하지 않았거나 공백일 경우
    if (authCodeController.text.isEmpty) {
      _showAlert('알림', '코드를 정확히 입력해주세요!');
    }
    // 사용자가 올바른 인증 코드를 입력한 경우
    else if (authCodeController.text == serverCode) {
      setState(() {
        isCodeVerified = true; // 인증 코드 확인
      });
      _showAlert('인증 성공', '새로운 비밀번호를 입력해주세요!');
    }
    // 사용자가 잘못된 인증 코드를 입력한 경우
    else {
      _showAlert('알림', '코드를 정확히 입력해주세요');
    }
  }

// AlertDialog를 표시하는 공통 함수
  void _showAlert(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop(); // 대화상자 닫기
              },
            ),
          ],
        );
      },
    );
  }

  // 비밀번호 검증 함수
  void _validatePasswords() {
    if (newPasswordController.text == checkPasswordController.text) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  void passwordVerification() async {
    try {
      String email = emailController.text.trim();
      String password = checkPasswordController.text.trim();

      var dio = Dio();
      var data = {
        "email": rightEmail,
        "password": password,
      };
      print(rightEmail);
      print(password);
      var response = await dio.patch(
        'https://$ip/api/auth/password',
        data: data,
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('성공'),
              content: Text('비밀번호가 성공적으로 변경되었습니다!\n로그인 해주세요!'),
              actions: <Widget>[
                CupertinoButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
                    );
                  },
                ),
              ],
            );
          },
        );
        print(serverCode);
      } else {
        print('Failed to send verification email or unexpected response format.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> getEmail(String email) async {
    final dio = Dio();
    final response = await dio.post(
      'https://$ip/api/auth/email',
      data: {"email": email},
    );
    if (response.statusCode == 200) {
      // 서버로부터 받은 인증 코드를 저장
      serverCode = response.data['code'];
      rightEmail = email; //정상 이메일(혹시나 수정할 수 있으니)
      // Show a success message using AlertDialog
    } else {
      // Handle errors or unsuccessful responses
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면의 너비와 높이를 가져옵니다.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultLayout(
      isResize: true,
      title: '비밀번호 찾기',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 현재 포커스를 제거하여 키보드를 내림
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupAskLabel(text: '이메일 입력'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextFormField(
                        controller: emailController,
                        onChanged: _validateEmail,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: isEmailValid ? (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text('알림'),
                                content: Text('이메일 주소로 인증번호가 전송되었습니다!'),
                                actions: <Widget>[
                                  CupertinoButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          getEmail(emailController.text.trim());
                        }:null,
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Text('코드 전송',style: customGreenTextSeventeenStyle,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                SignupAskLabel(text: '인증코드 입력'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5, // 비율을 사용하여 width를 조절
                      child: CustomTextFormField(
                        controller: authCodeController,
                        onChanged: (String value) {
                        },
                      ),
                    ),
                    SizedBox(width: 10), // 텍스트 필드와 버튼 사이의 간격
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _checkAuthCode,
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Text('코드 확인',style: customGreenTextSeventeenStyle,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SignupAskLabel(text: '새로운 비밀번호'),
                CustomTextFormField(
                  controller: newPasswordController,
                  onChanged: isValidPassword,
                  obscureText: true,
                  enable: isCodeVerified,
                ),
                SizedBox(
                  height: 10,
                ),
                SignupAskLabel(text: '새로운 비밀번호 확인'),
                CustomTextFormField(
                  controller: checkPasswordController,
                  onChanged: (String value) {
                    _validatePasswords();
                  },
                  obscureText: true,
                  enable: isCodeVerified,
                ),
                SizedBox(
                  height: screenHeight * 0.3,
                ),
                LoginNextButton(
                  onPressed: isButtonEnabled ? passwordVerification : () {}, // 변경된 부분
                  buttonName: '완료',
                  isButtonEnabled: isButtonEnabled,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
