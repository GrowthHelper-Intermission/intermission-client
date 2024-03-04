import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/notice/noti_model.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/notice/notice_detail_screen.dart';

class NoticeCard extends StatelessWidget {
  final String date;
  final String title;
  final int id;

  const NoticeCard({
    required this.date,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  factory NoticeCard.fromModel(NotiModel model) {
    return NoticeCard(
      date: model.postDate,
      title: model.title,
      id: model.id,
    );
  }

  String formatDate(String dateTime) {
    return dateTime.substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        //goNamed -> pushNamed
        context.pushNamed(NoticeDetailScreen.routeName,
            pathParameters: {'id': id.toString()});
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(date),
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(title,maxLines: 2,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[300], thickness: 0.5), // 구분선 추가
        ],
      ),
    );
  }
}

///
///
///