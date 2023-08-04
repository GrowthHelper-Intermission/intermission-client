import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/circular_progress_indicator.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  LoginUserProvider user = LoginUserProvider(); // Declare the user variable
  @override
  void initState() {
    initializeFlutterFire();
    checkAutoLogin();
    super.initState();
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }

  void checkAutoLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //SharedPreferences sp = await SharedPreferences.getInstance();
    bool autoLogin = sp.getBool(autoLoginKey) ?? false;
    if (autoLogin) {
      tryLogin();
    }
  }

  void tryLogin() async {
    // 로그인 시도 구현...
    // 사용자 정보 가져오기
    try {
      CircularProgressIndicator(color: PRIMARY_COLOR,);
      SharedPreferences sp = await SharedPreferences.getInstance();
      //sp.remove(userId); SharedPreference 비워줄때
      String stateId = sp.getString(userId) ?? '';
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(stateId)
          .get();
      user = LoginUserProvider.fromSnapshot(userData);
      print(user.emailAccount);

      // 로그인에 성공하면 다음 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainTab(user: user)),
      );
    } catch (e) {
      print(e);
      // 에러 처리
      showErrorDialog(context, '로그인에 실패했습니다.');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    DialogShow(context, message);
  }

  void goToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void goToSignUpPage1Screen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreenPage1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text('앱 이름', style: TextStyle(fontSize: 24)),
              Image.asset('assets/img/whitelogo.png',), //고등어 이미지.
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 2,
                          color: PRIMARY_COLOR,
                        )
                      ),
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignupScreenPage1(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            width: 1,
                            color: PRIMARY_COLOR,
                          ),
                      ),
                    ),
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
