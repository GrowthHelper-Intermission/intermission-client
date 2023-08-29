import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/report_model.dart';
import 'package:intermission_project/01.user/user/view/report_detail_screen.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';

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
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(date, style: TextStyle(color: Colors.grey[400])),
        onTap: () {
          print(isAnswer);
          context.goNamed(ReportDetailScreen.routeName, pathParameters: {'id': id});
        },
      ),
    );
  }
}
