import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';

class SignupLongAskLabel extends StatelessWidget {
  final String text;

  const SignupLongAskLabel({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 6,right: 20), //maxLine과 함께 범위 벗어나지않게
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 360, // 텍스트가 지정한 너비를 넘어가지 않도록 최대 너비 설정
        ),
        child: Text(
          text,
          style: customTextStyle,
          maxLines: 2,
        ),
      ),
    );
  }
}

