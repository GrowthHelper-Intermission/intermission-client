import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';

class SignupAskLabel extends StatelessWidget {
  final String text;
  const SignupAskLabel({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 30,
      child: Text(
        text,
        style: customTextStyle,
        maxLines: 2,
      ),
    );
  }
}
