import 'package:flutter/material.dart';
class SignupButton extends StatelessWidget {
  final String title;
  const SignupButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/signup1'),
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
