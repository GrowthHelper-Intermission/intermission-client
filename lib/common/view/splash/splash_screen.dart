import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/const/text_style.dart';

import '../../layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  final String message; // 옵셔널 파라미터

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