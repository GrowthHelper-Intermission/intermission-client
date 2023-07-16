import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/user/find_pw_button.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/user/signup_button.dart';
import 'package:intermission_project/views/home/home_body_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final globalKey = GlobalKey<FormState>();
  bool alwaysLoginCheck = false; // 자동 로그인 기능 추가
  final autoLoginStyle = TextStyle(color: PRIMARY_COLOR);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isButtonEnabled = false;
  String? _emailErrorText;
  String? _passwordErrorText;
  final int successCount = 0;

  void _checkButtonEnabled() {
    bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController.text);
    bool isPasswordValid = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$')
        .hasMatch(_passwordController.text);

    setState(() {
      _emailErrorText = isEmailValid ? null : '올바른 이메일 형식이 아닙니다';
      _passwordErrorText = isPasswordValid ? null : '올바른 비밀번호 형식이 아닙니다';
      _isButtonEnabled = isEmailValid && isPasswordValid;
    });
    // navigateToNextScreen(); // 수정된 부분
  }

  void tryLogin() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      CustomCircular(context, '로그인중...');
      DocumentSnapshot userData =
      await firestore.collection('users').doc(_emailController.text).get(); //테스트용 scott

      // Check if email and password match
      if (userData['emailAccount'] == _emailController.text &&
          userData['password'] == _passwordController.text) {
        if (alwaysLoginCheck) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('userId', _emailController.text);
          sp.setString('userPassword', _passwordController.text);
          sp.setBool('loginState', true);
        }

        LoginUserProvider user = LoginUserProvider.fromSnapshot(userData);
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                MainTabController(user: user)));
      } else {
        Navigator.pop(context);
        DialogShow(context, '회원정보가 잘못되었습니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '회원정보가 잘못되었습니다.');
    }
  }

  @override
  void initState() {
    _emailController.addListener(_checkButtonEnabled);
    _passwordController.addListener(_checkButtonEnabled);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                CustomAppBar(),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(24),
                      right: ScreenUtil().setWidth(24)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: SizedBox(
                          width: ScreenUtil().setWidth(73),
                          height: ScreenUtil().setHeight(40),
                          child: Text(
                            '로그인',
                            style: customHeaderStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 이메일 & TF
                            SizedBox(
                                width: 50,
                                height: 22,
                                child: Text(
                                  '이메일',
                                  style: customTextStyle,
                                )),
                            CustomTextFormField(
                              controller: _emailController,
                              hintText: 'email@email.com',
                              onChanged: (String value) {},
                            ),
                            // 비밀번호 & TF
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                                width: 60,
                                height: 22,
                                child: Text(
                                  '비밀번호',
                                  style: customTextStyle,
                                )),
                            CustomTextFormField(
                              controller: _passwordController,
                              hintText: '6자 이상의 영문/숫자 조합',
                              onChanged: (String value) {},
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                FindPWButton(title: '비밀번호 찾기'),
                                SignupButton(title: '회원가입 하기'),
                              ],
                            ),
                            SizedBox(
                              height: 300,
                            ),
                            LoginNextButton(
                              buttonName: '로그인',
                              isButtonEnabled: _isButtonEnabled,
                              onPressed: tryLogin,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future CustomCircular(context, String contentText) async {
  final ts = TextStyle(color: PRIMARY_COLOR);
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: SUB_BLUE_COLOR,
        title: Text(contentText, style: ts),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: PRIMARY_COLOR),
          ],
        ),
      );
    },
  );
}

