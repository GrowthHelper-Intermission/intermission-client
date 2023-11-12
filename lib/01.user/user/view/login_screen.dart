// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/etc/find_pw_button.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  bool _isLoading = false; // 로딩 중 상태를 나타내는 변수

  bool isLoginError = false;

  bool _isChecked = false;
  // bool _isAutoLogin = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _emailErrorText;
  String? _passwordErrorText;
  void _checkButtonEnabled() {
    bool isEmailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(_emailController.text);
    bool isPasswordValid = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$')
        .hasMatch(_passwordController.text);

    setState(() {
      _emailErrorText = isEmailValid ? null : '올바른 이메일 형식이 아닙니다';
      _passwordErrorText = isPasswordValid ? null : '올바른 비밀번호 형식이 아닙니다';
      _isButtonEnabled = isEmailValid && isPasswordValid;
    });
    // navigateToNextScreen(); // 수정된 부분
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                CustomAppBar(),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setWidth(24),
                  ),
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
                              ),
                            ),
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
                              ),
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              hintText: '6자 이상의 영문/숫자 조합',
                              onChanged: (String value) {},
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            //SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FindPWButton(title: '비밀번호 찾기'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LoginNextButton(
                              buttonName: _isLoading ? '로그인 중...' : '로그인', // 버튼 텍스트 조건부 설정
                              isButtonEnabled: _isButtonEnabled && !_isLoading, // 로딩 중일 때 버튼 비활성화
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true; // 로딩 중 상태로 변경
                                });
                                try {
                                  final result = await ref.read(userMeProvider.notifier).login(
                                    username: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                  if(result is UserModelError){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("아이디 혹은 비밀번호가 잘못되었습니다!"),
                                        backgroundColor: PRIMARY_COLOR, // 여기에 PRIMARYCOLOR 지정
                                        behavior: SnackBarBehavior.fixed, // 스낵바 스타일 설정
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                }  catch (e) {
                                  // 로그인 실패 시 스낵바를 표시
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("아이디 혹은 비밀번호가 잘못되었습니다!@@@"),
                                      backgroundColor: PRIMARY_COLOR, // 여기에 PRIMARYCOLOR 지정
                                      behavior: SnackBarBehavior.floating, // 스낵바 스타일 설정
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false; // 로딩 상태 해제
                                    });
                                  }

                                }
                              },
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
