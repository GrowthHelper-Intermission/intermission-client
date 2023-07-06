import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class LoginButton extends StatefulWidget {
  final bool isButtonEnabled;
  const LoginButton({required this.isButtonEnabled, super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed:
              widget.isButtonEnabled ? () {} : null,
              style: ElevatedButton.styleFrom(
                primary: widget.isButtonEnabled
                    ? PRIMARY_COLOR
                    : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),
              child: Text(
                '로그인',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

