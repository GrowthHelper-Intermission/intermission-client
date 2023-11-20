import 'package:flutter/material.dart';
import 'package:intermission_project/01.user/user/etc/find_pw_screen.dart';
import 'package:intermission_project/01.user/user/view/password_find_screen.dart';

import 'package:intermission_project/common/const/colors.dart';

class FindPWButton extends StatelessWidget {
  final String title;
  const FindPWButton({required this.title, super.key});

  // style: ElevatedButton.styleFrom(
  // primary: Colors.white,
  // shape: RoundedRectangleBorder(
  // borderRadius: BorderRadius.circular(10),
  // side: BorderSide(
  // width: 1,
  // color: PRIMARY_COLOR,
  // ),
  // ),

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
                color: Colors.black38,
              )
            )
          ),
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
              fontSize: 14.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
