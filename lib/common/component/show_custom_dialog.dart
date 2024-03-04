import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/const/colors.dart';

void showCustomDialog(BuildContext context, String message, VoidCallback onConfirm) {
  final screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 35, // Increase the height of the AlertDialog
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: screenWidth * 0.27,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR, // Use PRIMARY_COLOR from your constants
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context, '아니오'),
                  style: TextButton.styleFrom(primary: Colors.white),
                  child: Text(
                    '아니요',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 11),
              Container(
                width: screenWidth * 0.27,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, '예');
                    onConfirm();
                  },
                  style: TextButton.styleFrom(primary: Colors.white),
                  child: Text(
                    '예',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
