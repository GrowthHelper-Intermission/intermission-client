import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

import '../view/password/password_find_screen.dart';

class FindPWButton extends StatelessWidget {
  final String title;
  const FindPWButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: TextButton(
          style: TextButton.styleFrom(
              primary: SUB_BLUE_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                  side: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PasswordFindScreen(),
              ),
            );
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
