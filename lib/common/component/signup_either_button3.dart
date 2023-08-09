import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class SignupEitherButton3 extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SignupEitherButton3({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isSelected ? SUB_COLOR : Colors.white,
        minimumSize: Size(110, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
            color: isSelected ? Colors.transparent : BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.grey[600],
        ),
      ),
    );
  }
}