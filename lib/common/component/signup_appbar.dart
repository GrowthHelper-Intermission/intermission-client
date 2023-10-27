import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';

class SignupAppBar extends StatelessWidget {
  final String currentPage;
  const SignupAppBar({required this.currentPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: SizedBox(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(50),
            child: Text(
              '회원가입',
              style: customHeaderStyle,
            ),
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(50),
          child: Text(
            currentPage,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
