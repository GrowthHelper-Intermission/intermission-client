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

import '../../../common/component/custom_email_dropdown.dart';
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

  bool? serverCodeValidEmail;

  String? rightEmail;

  late FocusNode _emailFocusNode;
  OverlayEntry? _overlayEntry; // 이메일 자동 추천 드롭 박스.
  final LayerLink _layerLink = LayerLink();

  bool _isLoading = false; // 로딩 중 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    _emailFocusNode = FocusNode()
      ..addListener(() {
        if (!_emailFocusNode.hasFocus) {
          _removeEmailOverlay();
        }
      });
  }

  void isValidPassword(String password) {
    final trimmedPassword = newPasswordController.text.trim();

    // 영문, 숫자, 특수문자 포함 여부를 확인하기 위한 정규 표현식
    RegExp hasLetter = RegExp(r'[A-Za-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasSpecialCharacter = RegExp(r'[^A-Za-z0-9]');

    // 비밀번호 유효성 검사
    if (trimmedPassword.length >= 8 &&
        hasLetter.hasMatch(trimmedPassword) &&
        hasDigit.hasMatch(trimmedPassword) &&
        hasSpecialCharacter.hasMatch(trimmedPassword)) {
      setState(() {
        isPasswordValid = true;
      });
    } else {
      setState(() {
        isPasswordValid = false;
      });
    }
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

  // 이메일 드롭박스 해제.
  void _removeEmailOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

// 이메일 자동 입력창
  OverlayEntry _emailListOverlayEntry() {
    return customDropdown.emailRecommendation(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      layerLink: _layerLink,
      controller: emailController,
      onPressed: (String selectedValue) {
        setState(() {
          emailController.text = selectedValue;
          _removeEmailOverlay();
        });
      },
    );
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
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen()), // Navigate to LoginScreen
                    );
                  },
                ),
              ],
            );
          },
        );
        print(serverCode);
      } else if (response.statusCode == 404) {
        _showAlert("알림", "존재하지 않는 회원입니다.");
      } else if (response.statusCode == 400) {
        _showAlert("알림", "패스워드를 정확히 입력해주세요!");
      } else {
        _showAlert("알림", "네트워크 통신이 불안정합니다!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getEmail(String email) async {
    final dio = Dio();

    var data = {
      "email": email,
    };
    var response1 = await dio.post(
      'https://$ip/api/auth/email/check',
      data: data,
    );

    if (response1.statusCode == 200 && response1.data["isDuplicated"] is bool) {
      serverCodeValidEmail = response1.data["isDuplicated"];
      print(serverCodeValidEmail);

      // 중복 검사 결과에 따라 대화 상자를 띄움
      if (serverCodeValidEmail == true) {
        _showAlert('알림', '인증 코드가 전송되었습니다!');
        setState(() {
          _isLoading = false;
        });
        // 중복O -> 존재하는 계정인 경우로 임시 판별
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('알림'),
                content: Text('네트워크 연결이 불안정합니다!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop(); // 대화 상자를 닫음
                    },
                  ),
                ],
              );
            },
          );
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        _showAlert('알림', '존재하지 않는 계정입니다.');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // 이메일 입력창.
  Widget _emailTextField() {
    // 테두리 스타일.
    final _border = OutlineInputBorder(
      borderSide: BorderSide(
        color: (_emailFocusNode.hasFocus) ? PRIMARY_COLOR : Colors.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return  CompositedTransformTarget(
        link: _layerLink,
        child: SizedBox(
          height: 48,
          child: TextFormField(
            controller: emailController,
            focusNode: _emailFocusNode,
            onChanged: (value) {
              _validateEmail(value);
              setState(() {
                // 이메일 입력 시 오버레이 업데이트!
                if (_emailFocusNode.hasFocus &&
                    emailController.text.isNotEmpty &&
                    !emailController.text.contains('@')) {
                  // 기존 오버레이가 있다면 제거
                  if (_overlayEntry != null) {
                    _removeEmailOverlay();
                  }
                  print(value);
                  _overlayEntry = customDropdown.emailRecommendation(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    layerLink: _layerLink,
                    controller: emailController,
                    onPressed: (value) {
                      // 선택된 값을 emailController의 텍스트로 설정
                      setState(() {
                        emailController.text = value;
                        print(value);
                        _emailFocusNode.unfocus();
                        _removeEmailOverlay();
                      });
                    },
                  );
                  _overlayEntry = _emailListOverlayEntry();
                  Overlay.of(context).insert(_overlayEntry!);
                } else {
                  _removeEmailOverlay();
                }
              });
            },
            decoration: InputDecoration(
              // 여백.
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),

              // 테두리.
              border: _border,
              disabledBorder: _border,
              enabledBorder: _border,
              errorBorder: _border,
              focusedBorder: _border,
              focusedErrorBorder: _border,

              // 카운터.
              counter: null,
              counterText: '',

              // 힌트 메세지.
              hintText: 'email@email.com',
              hintStyle: const TextStyle(
                fontSize: 16,
                height: 22 / 16,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
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
                  children: [
                    Expanded(
                      flex: 5,
                      child: _emailTextField(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: // '코드 전송' 버튼
                            ElevatedButton(
                          onPressed: isEmailValid
                              ? () {
                                  // 이메일 주소로 인증 코드 전송
                                  getEmail(emailController.text.trim());
                                  setState(() {
                                    _isLoading = true; // 로딩 중 상태로 변경
                                  });
                                }
                              : null, // isEmailValid이 false일 경우 버튼 비활성화
                          style: ElevatedButton.styleFrom(
                            primary: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          child: _isLoading ? Text(
                            '전송중...',
                            style: customGreenTextSeventeenStyle,
                          ) : Text(
                            '코드 전송',
                            style: customGreenTextSeventeenStyle,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SignupAskLabel(text: '인증코드 입력'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5, // 비율을 사용하여 width를 조절
                      child: CustomTextFormField(
                        controller: authCodeController,
                        onChanged: (String value) {},
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Text(
                          '코드 확인',
                          style: customGreenTextSeventeenStyle,
                        ),
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
                  errorText: isPasswordValid == false
                      ? '8자 이상의 영문/숫자/특수문자 조합 필요'
                      : null, // 에러 텍스트 추가
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
                  onPressed:
                      isButtonEnabled ? passwordVerification : () {}, // 변경된 부분
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
