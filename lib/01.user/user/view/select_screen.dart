import 'package:flutter/material.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/common/const/colors.dart';
class SelectScreen extends StatelessWidget {
  static String get routeName => 'select';

  const SelectScreen({super.key});

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