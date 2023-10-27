import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

Future CustomCircularProgressIndicator( context,String contentText) async {
  final ts = TextStyle(color: PRIMARY_COLOR);
  return await showDialog(
    context: context,
    barrierDismissible : false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: SUB_BLUE_COLOR,
        title: Text(contentText,style: ts),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            CircularProgressIndicator(color: PRIMARY_COLOR),
          ],
        ),
      );
    },
  );
}
