import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/view/research_detail_screen.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/setting/setting_screen.dart';
// enum onlineCategory {
//   online,
//   offline,
//   both,
// }

class ResearchCard extends StatefulWidget {
  final String id; // PK
  final String mainTitle; // ex) 뇌졸중 환자 및 보호자
  final String subTitle; //ex) 온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final String dueDate; // yyyy-mm-dd
  final String exceptTime;
  final String researchMethTpCd;
  final String researchRewdAmt;
  // final String isOnline; // 대면 여부
  // final String hourlyRate; // 1시간 3만원

  final String isOnGoing; // 진행 여부

  const ResearchCard({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.exceptTime,
    required this.researchRewdAmt,
    required this.researchMethTpCd,
    required this.dueDate,
    required this.isOnGoing,
    super.key,
  });

  factory ResearchCard.fromModel({
    required ResearchModel model,
    bool isDetail = false,
  }) {
    return ResearchCard(
      id: model.id,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      // isOnline: onlineCategory.values.firstWhere((e) =>
      // e.name.toString() == model.isOnline.toString()),
      researchMethTpCd: model.researchMethTpCd,
      exceptTime: model.exceptTime,
      researchRewdAmt: model.researchRewdAmt,
      dueDate: model.dueDate,
      isOnGoing: model.isOnGoing,
    );
  }

  @override
  State<ResearchCard> createState() => _ResearchCardState();
}

class _ResearchCardState extends State<ResearchCard> {
  int daysLeft = 0;

  @override
  void initState() {
    _getDaysLeft();
    super.initState();
  }

  int _getDaysLeft() {
    DateTime now = DateTime.now();
    DateTime interviewDate = DateTime.parse(widget.dueDate);
    Duration difference = interviewDate.difference(now);
    return difference.inDays + 1;
  }

  @override
  Widget build(BuildContext context) {
    daysLeft = _getDaysLeft(); // Every time the widget is built, update the days left.

    return Padding(
      padding: const EdgeInsets.fromLTRB(11, 0, 21, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            context.goNamed(ResearchDetailScreen.routeName,
                pathParameters: {'id': widget.id});
          },
          child: Container(
            width: 335,
            height: 138,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey.shade200,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 21,
                        decoration: BoxDecoration(
                          color: daysLeft <= 3 ? Colors.white : SUB_BLUE_COLOR,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: SUB_BLUE_COLOR,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'D-$daysLeft',
                            style: TextStyle(
                              color: daysLeft <= 3 ? SUB_BLUE_COLOR : Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.mainTitle,
                          style: InterviewTitleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 1),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      widget.subTitle,
                      style: whiteSmallTextStyle,
                      maxLines: 2,
                    ),
                  ),
                  Flexible(
                    child: Container(), // This takes up the remaining space
                  ),
                  Row(
                    children: [
                      Text(
                        widget.researchMethTpCd,
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        ' | ',
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        '${widget.exceptTime}시간 ',
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        widget.researchRewdAmt,
                        style: whiteSmallTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
