import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

class OngoingInterviewHeader extends StatelessWidget {
  final VoidCallback onMorePressed;

  const OngoingInterviewHeader({required this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(27, 8, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '진행 중인 인터뷰',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          TextButton(
            onPressed: onMorePressed,
            child: Text(
              'More',
              style: TextStyle(
                color: SUB_BLUE_COLOR,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
