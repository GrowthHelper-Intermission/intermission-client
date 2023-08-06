import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoLogin', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                    (route) => false,
              );
            },
            child: Text('로그아웃 하기'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR), // PRIMARY_COLOR 적용
            ),
          ),
        ],
      ),
    );
  }
}
