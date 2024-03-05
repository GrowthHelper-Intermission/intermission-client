import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class BottomBarNextButton extends StatelessWidget {
  final String buttonName;
  final bool isButtonEnabled;
  final VoidCallback? onPressed;

  const BottomBarNextButton({
    required this.onPressed,
    required this.buttonName,
    required this.isButtonEnabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: isButtonEnabled ? PRIMARY_COLOR : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}