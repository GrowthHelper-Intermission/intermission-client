import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  // final globalKey = GlobalKey<FormState>();
  // final autoLoginStyle = TextStyle(color: PRIMARY_COLOR);
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

  // void tryLogin({String? email, String? password}) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   bool autoLogin = sp.getBool(autoLoginKey) ?? false; // 추가된 부분
  //
  //   String userEmail = email ?? _emailController.text;
  //   String userPassword = password ?? _passwordController.text;
  //
  //   try {
  //     //CustomCircular(context, '로그인중...');
  //     CircularProgressIndicator(color: PRIMARY_COLOR,);
  //     DocumentSnapshot userData =
  //     await firestore.collection('users').doc(userEmail).get();
  //
  //     // Check if email and password match
  //     if (userData['emailAccount'] == userEmail &&
  //         userData['password'] == userPassword) {
  //       LoginUserProvider user = LoginUserProvider.fromSnapshot(userData);
  //       // 자동 로그인 정보 저장
  //       if (_isChecked) {
  //         sp.setString(userId, userEmail);
  //         sp.setString(userPassword, userPassword);
  //         sp.setBool(autoLoginKey, true);
  //       }
  //       Navigator.pop(context);
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => RootTab(user: user)));
  //     } else if (autoLogin) { // 수정된 부분
  //       Navigator.pop(context);
  //       tryLogin(
  //           email: sp.getString(userId), password: sp.getString(userPassword));
  //     } else {
  //       Navigator.pop(context);
  //       DialogShow(context, 'error1.');
  //       DialogShow(context, '회원정보가 잘못되었습니다.');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     Navigator.pop(context);
  //     DialogShow(context, 'error2.');
  //     DialogShow(context, '회원정보가 잘못되었습니다.');
  //   }
  // }

  // Future<void> setAutoLogin({required bool value}) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.setBool(autoLoginKey, value);
  // }

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
    final state = ref.watch(userMeProvider);

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
                              buttonName: '로그인',
                              isButtonEnabled: _isButtonEnabled,
                              onPressed: (){

                              },
                            ),
                            // ElevatedButton(
                            //   onPressed: state is UserModelLoading
                            //       ? null
                            //       : () async {
                            //     ref.read(userMeProvider.notifier).login(
                            //       username: _emailController.text.trim(),
                            //       password: _passwordController.text.trim(),
                            //     );
                            //     // // ID:비밀번호
                            //     // final rawString = '$username:$password';
                            //     //
                            //     // Codec<String, String> stringToBase64 = utf8.fuse(base64);
                            //     //
                            //     // String token = stringToBase64.encode(rawString);
                            //     //
                            //     // final resp = await dio.post(
                            //     //   'http://$ip/auth/login',
                            //     //   options: Options(
                            //     //     headers: {
                            //     //       'authorization': 'Basic $token',
                            //     //     },
                            //     //   ),
                            //     // );
                            //     //
                            //     // final refreshToken = resp.data['refreshToken'];
                            //     // final accessToken = resp.data['accessToken'];
                            //     //
                            //     // final storage = ref.read(secureStorageProvider);
                            //     //
                            //     // await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                            //     // await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
                            //     //
                            //     // Navigator.of(context).push(
                            //     //   MaterialPageRoute(
                            //     //     builder: (_) => RootTab(),
                            //     //   ),
                            //     // );
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     primary: PRIMARY_COLOR,
                            //   ),
                            //   child: Text(
                            //     '로그인',
                            //   ),
                            // ),
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
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CircularProgressIndicator(
        backgroundColor: PRIMARY_COLOR,
      );
    },
  );
}


// Future CustomCircular(context, String contentText) async {
//   final ts = TextStyle(color: PRIMARY_COLOR);
//   return await showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: PRIMARY_COLOR,
//         title: Text(contentText, style: ts),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: PRIMARY_COLOR),
//           ],
//         ),
//       );
//     },
//   );
// }

class AutoLoginCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final ValueChanged<bool> onAutoLoginChanged;
  const AutoLoginCheckbox({
    required this.isChecked,
    required this.onChanged,
    required this.onAutoLoginChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        height: 60,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                value: isChecked,
                activeColor: Colors.black,
                checkColor: Colors.white,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                  onAutoLoginChanged(newValue!);
                },
              ),
            ),
            const Text(
              '자동 로그인',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
