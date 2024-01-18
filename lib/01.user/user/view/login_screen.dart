// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

import '../../../common/component/custom_email_dropdown.dart';



class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String initEmail = '';
  late SharedPreferences _prefs;

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

  late FocusNode _emailFocusNode;
  OverlayEntry? _overlayEntry; // 이메일 자동 추천 드롭 박스.
  final LayerLink _layerLink = LayerLink();

  // 이메일 드롭박스 해제.
  void _removeEmailOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void loadEmail() async{
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      initEmail = (_prefs.getString('email') ?? '');
      _emailController.text = initEmail;
      print(initEmail);
    });
  }

  @override
  void initState() {
    _emailController.addListener(_checkButtonEnabled);
    _passwordController.addListener(_checkButtonEnabled);
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode()
      ..addListener(() {
        if (!_emailFocusNode.hasFocus) {
          _removeEmailOverlay();
        }
      });
    super.initState();
    loadEmail();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _overlayEntry?.dispose();
    super.dispose();
  }

  void closeDropdown() {
    final _currentFocus = FocusScope.of(context);
    if (!_currentFocus.hasPrimaryFocus) {
      _currentFocus.unfocus();
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

// 이메일 자동 입력창
  OverlayEntry _emailListOverlayEntry() {
    return customDropdown.emailRecommendation(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      layerLink: _layerLink,
      controller: _emailController,
      onPressed: (String selectedValue) {
        print('keke');
        setState(() {
          _emailController.text = selectedValue;
          _removeEmailOverlay();
        });
      },
    );
  }

  // 이메일 입력창.
  Widget _emailTextField() {
    // 테두리 스타일.
    final _border = OutlineInputBorder(
      borderSide: BorderSide(
        color: (_emailFocusNode.hasFocus) ? PRIMARY_COLOR : BORDER_COLOR,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: 48,
          child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            onChanged: (value) {
              setState(() {
                // 이메일 입력 시 오버레이 업데이트!
                if (_emailFocusNode.hasFocus &&
                    _emailController.text.isNotEmpty &&
                    !_emailController.text.contains('@')) {
                  // 기존 오버레이가 있다면 제거
                  if (_overlayEntry != null) {
                    print("here");
                    _removeEmailOverlay();
                  }
                  print(value);
                  _overlayEntry = customDropdown.emailRecommendation(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    layerLink: _layerLink,
                    controller: _emailController,
                    onPressed: (value) {
                      // 선택된 값을 emailController의 텍스트로 설정
                      setState(() {
                        closeDropdown();
                        _emailController.text = value;
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: closeDropdown,
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
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
                            // CustomTextFormField(
                            //   controller: _emailController,
                            //   hintText: 'email@email.com',
                            //   onChanged: (String value) {},
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: _emailTextField(),
                            ),
// 비밀번호 & TF
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              width: 100,
                              height: 22,
                              child: Text(
                                '비밀번호',
                                style: customTextStyle,
                              ),
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              hintText: '8자 이상의 영문/숫자/특수문자 조합',
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
                                  child: FindPWButton(
                                    title: '비밀번호 찾기',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LoginNextButton(
                              buttonName: _isLoading
                                  ? '로그인 중...'
                                  : '로그인', // 버튼 텍스트 조건부 설정
                              isButtonEnabled: _isButtonEnabled &&
                                  !_isLoading, // 로딩 중일 때 버튼 비활성화
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true; // 로딩 중 상태로 변경
                                });
                                try {
                                  final result = await ref
                                      .read(userMeProvider.notifier)
                                      .login(
                                        username: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      );

                                  if (result is UserModelError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("아이디 혹은 비밀번호가 잘못되었습니다!"),
                                        backgroundColor:
                                            PRIMARY_COLOR, // 여기에 PRIMARYCOLOR 지정
                                        behavior: SnackBarBehavior
                                            .fixed, // 스낵바 스타일 설정
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }else{
                                    print('like this');
                                    // 로그인 성공 시, 이메일 저장
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('email', _emailController.text.trim());
                                  }
                                } catch (e) {
                                  // 로그인 실패 시 스낵바를 표시
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("아이디 혹은 비밀번호가 잘못되었습니다!@@@"),
                                      backgroundColor:
                                          PRIMARY_COLOR, // 여기에 PRIMARYCOLOR 지정
                                      behavior: SnackBarBehavior
                                          .floating, // 스낵바 스타일 설정
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
