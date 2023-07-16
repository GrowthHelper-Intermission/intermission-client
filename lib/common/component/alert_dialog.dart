import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

Future DialogShow(context, String contentText) async {
  final ts = TextStyle(color: SUB_BLUE_COLOR);
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: SUB_BLUE_COLOR,
        title: Text('알림', style: ts),
        content: Text(contentText, style: ts),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('확인', style: ts),
          ),
        ],
      );
    },
  );
}
