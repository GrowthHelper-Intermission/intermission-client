import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_check_box.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/signup_appbar.dart';
import 'package:intermission_project/common/component/signup_ask_label.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/const/type_data.dart';
import 'package:intl/intl.dart';

import '../../../common/component/custom_dropdown_button.dart';

class SignupScreenPage1 extends ConsumerStatefulWidget {
  static String get routeName => 'signup1';
  const SignupScreenPage1({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreenPage1> createState() => _SignupScreenPage1State();
}

class _SignupScreenPage1State extends ConsumerState<SignupScreenPage1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController emailTypeController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String selectedEmailType = "naver.com";
  bool isAgree = false;
  bool isAgree2 = false;
  bool isPasswordValid = false;
  bool isEmailVerified = false;
  bool isButtonEnabled = false;

  bool? serverCode;  // String? 대신 bool? 타입으로 변경

  late String fixedEmail;

  late String realFixedEmail;



  // 비밀번호 유효성 검사 함수
  void validatePassword(String password) {
    if (password.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'\d').hasMatch(password) &&
        RegExp(r'[^A-Za-z0-9]').hasMatch(password)) {
      setState(() {
        isPasswordValid = true;
      });
    } else {
      setState(() {
        isPasswordValid = false;
      });
    }
    checkButtonEnabled();
  }

  void sendEmailVerification() async {
    try {
      if(emailController.text.isEmpty){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('알림'),
              content: Text('이메일을 입력해주세요!'),
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
      }
      fixedEmail = '${emailController.text.trim()}@$selectedEmailType';
      var dio = Dio();
      var data = {
        "email": fixedEmail,
      };
      var response = await dio.post(
        'https://$ip/api/auth/email/check',
        data: data,
      );

      if (response.statusCode == 200 && response.data["isDuplicated"] is bool) {
        serverCode = response.data["isDuplicated"];
        print(serverCode);

        // 중복 검사 결과에 따라 대화 상자를 띄움
        if (serverCode == true) {
          // 중복된 이메일인 경우
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('알림'),
                content: Text('이미 사용중인 아이디입니다.'),
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
        } else {
          // 사용 가능한 이메일인 경우
          isEmailVerified = true;
          realFixedEmail = fixedEmail;
          checkButtonEnabled();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('알림'),
                content: Text('사용 가능한 아이디입니다!'),
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
        }
      } else {
        print('Failed to send verification email or unexpected response format.');
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // 버튼 활성화 상태 업데이트 함수
  void checkButtonEnabled() {
    if (isEmailVerified && isPasswordValid && isAgree && isAgree2) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void closeDropdown() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: closeDropdown,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(12),
                    right: ScreenUtil().setWidth(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignupAppBar(currentPage: '1/2'),
                    SignupAskLabel(text: '이메일'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2, // 비율을 사용하여 width를 조절
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: 'email',
                            onChanged: (String value) {
                              // checkEmailEnabled();
                            },
                            // errorText: emailErrorText,
                          ),
                        ),
                        Text('@'),
                        Expanded(
                          flex: 2,
                          child: selectedEmailType == '직접입력'
                              ? CustomTextFormField(
                            controller: emailTypeController,
                            hintText: 'domain.com',
                            onChanged: (String value) {
                              selectedEmailType = value;
                            },
                          )
                              : CustomDropdownButton(
                            dropdownWidth: 130,
                            items: emailTypes,
                            hintText: 'naver.com',
                            onItemSelected: (value) {
                              setState(() {
                                selectedEmailType = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: sendEmailVerification,
                            style: ElevatedButton.styleFrom(
                              primary: PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 4),
                            ),
                            child: Text('중복\n확인',style: customGreenTextSeventeenStyle,),
                          ),
                        )
                      ],
                    ),
                    SignupAskLabel(text: '비밀번호'),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '8자 이상의 영문/숫자/특수문자 조합',
                      onChanged: validatePassword,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomCheckBox(
                      isAgree: isAgree,
                      title: '[필수]이용약관에 동의합니다.',
                      onChanged: (value) {
                        setState(() {
                          isAgree = value!;
                          checkButtonEnabled();
                        });
                      },
                      fontSize: 16,
                      isDetail: true,
                      url: 'https://docs.google.com/document/d/e/2PACX-1vTNbqTr-co8U-S9KnXI3ruFGz1FEnv5GymdwX7hvRrFI4ewsOWVQGlTgsc7nIIpXrtz-gVLJfLjzAXd/pub',
                    ),
                    CustomCheckBox(
                      isAgree: isAgree2,
                      title: '[필수]개인정보 처리방침에 동의합니다.',
                      onChanged: (value) {
                        setState(() {
                          isAgree2 = value!;
                          checkButtonEnabled();
                        });
                      },
                      fontSize: 16,
                      isDetail: true,
                      url: 'https://docs.google.com/document/d/e/2PACX-1vSi6kk5dKbu2mQuWPrYEj7FR0Xe6xgjOkKVSNEWT7Bkp4XfzirQaegXbM2Frtp3cC5-S0RnJp2VqeTx/pub',
                    ),
                    SizedBox(height: 300,),
                    LoginNextButton(
                      buttonName: '다음',
                      // isButtonEnabled: isButtonEnabled,
                      isButtonEnabled: isButtonEnabled,
                      onPressed: () {
                        final state = ref.read(signupUserProvider.notifier);
                        // //10개
                        state.setEmail(realFixedEmail);
                        state.setPassword(passwordController.text.trim());
                        state.setIsPrivacyAgreed(isAgree == true ? "Y" : "N");
                        state.setIsTermsAgreed(isAgree2 == true ? "Y" : "N");

                        context.pushNamed(SignupScreenPage2.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final bool
      istext; //버튼안에 들어갈 내용이 '중복확인' 텍스트인가 화살표아이콘인가를 결정해주는 변수임 164번줄에 이어서 주석달겠음.
  final String text;
  final VoidCallback onPressed;
  const CustomButton(
      {required this.text,
      required this.istext,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: PRIMARY_COLOR,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: onPressed,
      child: istext == false
          ? Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 35.0,
            )
          : Text(text),
    );
  }
}