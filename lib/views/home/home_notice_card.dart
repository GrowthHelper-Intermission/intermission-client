import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/const/colors.dart';

class NoticeCard extends StatelessWidget {
  final String notice;
  final String noticeContent;

  const NoticeCard({
    required this.notice,
    required this.noticeContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 84,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: SUB_COLOR,
        ),
        color: SUB_COLOR,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 18,
                child: Text(
                  '[공지]',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9C5EDA),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 2,
            // ),
            Expanded(
              child: Container(
                height: 40,
                child: Text(
                  '$notice',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                height: 14,
                child: Text(
                  '$noticeContent',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
