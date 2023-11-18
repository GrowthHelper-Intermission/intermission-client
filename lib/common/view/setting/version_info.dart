import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class VersionInfoScreen extends StatelessWidget {
  const VersionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      title: '버전 정보',
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/launcher_icon/iconapp.png'),
            Text('현재 버전은 1.1.0입니다.',style: TextStyle(fontSize: 30,color: PRIMARY_COLOR),),
          ],
        ),
      ),
    );
  }
}