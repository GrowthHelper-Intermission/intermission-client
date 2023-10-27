import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class DateDisplayWidget extends StatelessWidget {
  final int daysLeft;

  DateDisplayWidget({super.key, required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    String displayText;
    Color borderColor;
    Color textColor;
    Color backgroundColor;

    if (daysLeft > 3) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft > 0) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft == 0) {
      displayText = 'D-day';
      borderColor = SUB_BLUE_COLOR;
      textColor = Colors.white;
      backgroundColor = SUB_BLUE_COLOR;
    } else {
      displayText = '마감';
      borderColor = PRIMARY_COLOR;
      textColor = Colors.white;
      backgroundColor = PRIMARY_COLOR;
    }

    return Container(
      width: 50,
      height: 21,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          displayText,
          style: TextStyle(
            color: textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
