import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/user/user/view/login_screen.dart';
import 'package:intermission_project/user/user/view/signup_screen_page1.dart';
class SelectScreen extends StatelessWidget {
  static String get routeName => 'select';

  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: PRIMARY_COLOR2,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.12,),
            Image.asset('assets/img/intermissionLogo2.png',height: screenHeight * 0.5,),
            SizedBox(height: screenHeight * 0.13),
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
    );
  }
}