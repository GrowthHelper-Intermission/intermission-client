import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/models/user.dart';
import 'package:intermission_project/user/matching_screen.dart';
import 'package:intermission_project/views/setting/setting_screen.dart';
import 'package:provider/provider.dart';

class InterviewCard extends StatefulWidget {
  final LoginUserProvider user;
  final String interviewId;
  final String interviewDate;
  final Color color;
  final String title;
  final String recruiting;
  final bool onlyOnline;
  final String hourlyRate;
  const InterviewCard({
    required this.user,
    required this.interviewId,
    required this.interviewDate,
    required this.color,
    required this.title,
    required this.recruiting,
    required this.onlyOnline,
    required this.hourlyRate,
    Key? key,
  }) : super(key: key);

  @override
  State<InterviewCard> createState() => _InterviewCardState();
}

class _InterviewCardState extends State<InterviewCard> {
  int daysLeft = 0;
  late LoginUserProvider user = widget.user;

  @override
  void initState() {
    _getDaysLeft();
    super.initState();
  }

  int _getDaysLeft() {
    DateTime now = DateTime.now();
    DateTime interviewDate = DateTime.parse(widget.interviewDate);
    Duration difference = interviewDate.difference(now);
    return difference.inDays + 1;
  }

  //provider로 user 정보 받아서 추가해줘야 된다
  void _scrapInterview() async {
    // Get the LoginUserProvider instance from the provider context.
    print(user.emailAccount);
    // Add the interview id to the scrapedInterviews list.
    user.addScrapedInterview(widget.interviewId);
    print(widget.interviewId);
    //String uid = userProvider.emailAccount;
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user.emailAccount)
    //     .update({
    //   'scrapedInterviews': widget.interviewId,
    // }).catchError((error) {
    //   print("Error updating document: $error");
    // });


    print(FirebaseFirestore.instance
        .collection("users")
        .doc(user.emailAccount));
  }


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
                          widget.title,
                          style: InterviewTitleStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: _scrapInterview,
                      splashColor: Colors.red, // 클릭 효과의 색상 설정
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
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
                    widget.recruiting,
                    style: InterviewRecruitingStyle,
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 18,
                      child: Text(
                        widget.onlyOnline ? '비대면/대면 | ' : '온라인 | ',
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
