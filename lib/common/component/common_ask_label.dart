import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/text_style.dart';

class CommonAskLabel extends StatelessWidget {
  final String text;
  const CommonAskLabel({required this.text, super.key});

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
