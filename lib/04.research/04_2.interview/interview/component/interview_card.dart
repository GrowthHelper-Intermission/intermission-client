import 'package:flutter/material.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/model/interview_model.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/views/setting/setting_screen.dart';

import '../../../../common/const/colors.dart';

// enum onlineCategory{
//   online,
//   offline,
//   both,
// }
//
// class InterviewModel implements IModelWithId {
//   final String id; // PK
//   final String mainTitle; // ex)뇌졸중 환자 및 보호자
//   final String subTitle; //ex)온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
//   final onlineCategory isOnline; //대면여부
//   final String hourlyRate; //1시간 3만원
//   final String dueDate; //yyyy-mm-dd
//   final bool isOnGoing; //진행여부
//
//   InterviewModel({
//     required this.id,
//     required this.mainTitle,
//     required this.subTitle,
//     required this.dueDate,
//     required this.isOnline,
//     required this.hourlyRate,
//     required this.isOnGoing,
//   });
// }

enum onlineCategory {
  online,
  offline,
  both,
}

class InterviewCard extends StatefulWidget {
  final String id; // PK
  final String mainTitle; // ex)뇌졸중 환자 및 보호자
  final String subTitle; //ex)온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final onlineCategory isOnline; //대면여부
  final String hourlyRate; //1시간 3만원
  final String dueDate; //yyyy-mm-dd
  final bool isOnGoing; //진행여부

  const InterviewCard({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.isOnline,
    required this.hourlyRate,
    required this.dueDate,
    required this.isOnGoing,
    super.key,
  });

  factory InterviewCard.fromModel({
    required InterviewModel model,
    bool isDetail = false,
  }) {
    return InterviewCard(
      id: model.id,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      isOnline: onlineCategory.values.firstWhere((e) =>
      e.name.toString() == model.isOnline.toString()),
      hourlyRate: model.hourlyRate,
      dueDate: model.dueDate,
      isOnGoing: model.isOnGoing,
    );
  }

  @override
  State<InterviewCard> createState() => _InterviewCardState();

}


class _InterviewCardState extends State<InterviewCard> {
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

  // //provider로 user 정보 받아서 추가해줘야 된다
  // void _scrapInterview() async {
  //   // Get the LoginUserProvider instance from the provider context.
  //   // print(user.emailAccount);
  //   // Add the interview id to the scrapedInterviews list.
  //   // user.addScrapedInterview(widget.interviewId);
  //   print(widget.id);
  //
  //   // print(FirebaseFirestore.instance
  //   //     .collection("users")
  //   //     .doc(user.emailAccount));
  // }

  @override
  Widget build(BuildContext context) {
    daysLeft = _getDaysLeft(); // Every time the widget is built, update the days left.
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 12, 21, 2),
      child: Container(
        width: 335,
        height: 138,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.white,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'D-$daysLeft',  // 수정된 부분
                          style: TextStyle(
                            color: daysLeft <= 3 ? SUB_BLUE_COLOR : Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 21,
                        child: Text(
                          widget.id,
                          style: InterviewTitleStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // InkWell(
                    //   onTap: _scrapInterview,
                    //   splashColor: Colors.red, // 클릭 효과의 색상 설정
                    //   child: Icon(
                    //     Icons.arrow_forward_ios,
                    //     size: 18,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 1,
                  width: 293,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 293, //same with line
                  height: 40,
                  child: Text(
                    widget.subTitle,
                    style: InterviewRecruitingStyle,
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 18,
                      child:   Text(
                        widget.isOnline == onlineCategory.online
                            ? '비대면'
                            : widget.isOnline == onlineCategory.offline
                            ? '대면'
                            : '대면/비대면',
                        style: InterviewOnlyOnlineStyle,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(
                        widget.hourlyRate,
                        style: InterviewHourlyRateStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
}
}