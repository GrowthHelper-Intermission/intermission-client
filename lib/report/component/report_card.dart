import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/report/model/report_model.dart';
import 'package:intermission_project/report/view/report_detail_screen.dart';

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
      date: model.postDate ?? '테스트 데이터들로 날짜 정보 없음',
      title: model.mainTitle,
      id: model.id.toString(),
      isAnswer: model.isAnswer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            //goNamed -> pushNamed
            context.pushNamed(ReportDetailScreen.routeName,
                pathParameters: {'id': id});
          },
          child: Padding(
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(color: Colors.grey[300], thickness: 0.5), // 구분선 추가
      ],
    );
  }
}

