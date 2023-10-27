import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/data.dart';

class LogoutScreen extends ConsumerWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  // Future<void> logout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('autoLogin', false);
  // }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print('fws');
              ref.read(userMeProvider.notifier).logout();
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