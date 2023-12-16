// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/component/alert_dialog.dart';
import 'package:intermission_project/common/component/circular_progress_indicator.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/common/view/root_tab.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  final String message; // 옵셔널 파라미터

  // 생성자에서 message 파라미터에 기본값을 할당합니다.
  SplashScreen({Key? key, this.message = '앱 정보를 가져오는중...'}) : super(key: key);

  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Color(0xFF469946),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/launcher_icon/iconapp2.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            Text(
              message, // 사용된 옵셔널 파라미터
              style: whiteWhiteSmallTextStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}