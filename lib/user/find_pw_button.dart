import 'package:flutter/material.dart';
import 'package:intermission_project/user/find_pw.dart';

class FindPWButton extends StatelessWidget {
  final String title;
  const FindPWButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FindPassword(),
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
