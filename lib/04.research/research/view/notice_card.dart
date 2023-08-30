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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        Divider(color: Colors.grey[300], thickness: 0.5), // 구분선 추가
      ],
    );
  }
}
