import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/circular_progress_indicator.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/views/signup/signup_screen_page1.dart';
import 'package:intermission_project/views/signup/signup_screen_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png'), //고등어 이미지.
            ElevatedButton(
              onPressed: tryLogin,
              child: Text('시작하기'),
            ),
            const IntroBottom(),
          ],
        ),
      ),
    );
  }

  void tryLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String stateId = sp.getString(userId) ?? '';
    String statePassword = sp.getString(userPassword) ?? '';
    bool autoLogin = sp.getBool(autoLoginKey) ?? false;
    if (autoLogin && stateId.isNotEmpty) {
      print(autoLogin);
      CustomCircularProgressIndicator(context, '로그인중...');
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(stateId)
            .get();
        LoginUserProvider user = LoginUserProvider.fromSnapshot(userData);
        if (stateId == user.emailAccount && statePassword == user.password) {
          Navigator.pop(context);
          goToMainScreen(user);
        } else {
          showErrorDialog(context, '자동 로그인 기능 .');
          print('debug1');
          goToMainScreen(user);
        }
      } catch (e) {
        showErrorDialog(context, '로그인이 필요합니다');
        print('debug2');
        goToLoginScreen(context);
      }
    } else {
      showErrorDialog(context, '로그인이 필요합니다');
      print('debug3');
      goToLoginScreen(context);
    }
  }

  void goToMainScreen(LoginUserProvider user) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MainTabController(user: user)));
  }

  void goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void goToSignUpPage1Screen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SignupScreenPage1()));
  }

  void goToSignUpPage2Screen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SignupScreenPage2()));
  }

  void showErrorDialog(BuildContext context, String message) {
    DialogShow(context, message);
  }
}

class IntroBottom extends StatelessWidget {
  const IntroBottom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Text(
            'Growth Helper',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '꿀수익 보장!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          Text(
            'Test.ver',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
