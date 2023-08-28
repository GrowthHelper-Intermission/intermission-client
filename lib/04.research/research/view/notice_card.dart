import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/model/noti_model.dart';
import 'package:intermission_project/04.research/research/view/notice_detail_screen.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';

class NoticeCard extends StatelessWidget {
  final String date;
  final String title;
  final String id;

  const NoticeCard({
    required this.date,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);


  factory NoticeCard.fromModel(NotiModel model) {
    return NoticeCard(
      date: model.postDate,
      title: model.mainTitle,
      id: model.id,
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
          context.goNamed(NoticeDetailScreen.routeName, pathParameters: {'id': id});
        },
      ),
    );
  }
}
