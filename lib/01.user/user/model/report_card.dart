import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/report_model.dart';
import 'package:intermission_project/01.user/user/view/report_detail_screen.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/common/const/colors.dart';

class ReportCard extends StatelessWidget {
  final String date;
  final String title;
  final String id;
  final String isAnswer;

  const ReportCard({
    required this.date,
    required this.title,
    required this.id,
    required this.isAnswer,
    Key? key,
  }) : super(key: key);

  factory ReportCard.fromModel(ReportModel model) {
    return ReportCard(
      date: model.postDate,
      title: model.mainTitle,
      id: model.id,
      isAnswer: model.isAnswer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Container(
                      width: 70,  // Adjust the width as per your requirement
                      height: 28,
                      decoration: BoxDecoration(
                        color: isAnswer == "true" ? PRIMARY_COLOR : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isAnswer == "true" ? PRIMARY_COLOR : Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          isAnswer == "true" ? '답변완료' : '답변대기',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(color: Colors.grey[300], thickness: 0.5), // 구분선 추가
      ],
    );
  }
}

