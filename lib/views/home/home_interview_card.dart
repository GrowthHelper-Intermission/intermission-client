import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/user/matching_screen.dart';

class InterviewCard extends StatelessWidget {
  final int dDay;
  final Color color;
  final String title;
  final String recruiting;
  final bool onlyOnline;
  final String hourlyRate;
  const InterviewCard(
      {
        required this.dDay,
      required this.color,
      required this.title,
      required this.recruiting,
      required this.onlyOnline,
      required this.hourlyRate,
      super.key
      });

  @override
  Widget build(BuildContext context) {
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
                      color: SUB_BLUE_COLOR,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'D-$dDay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      height: 21,
                      child: Text(
                        title,
                        style: InterviewTitleStyle,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      // Replace 'YourDestinationScreen()' with the screen you want to navigate to
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchingScreen(),
                          )
                      );
                    },
                    child: Icon(Icons.arrow_forward_ios,size: 18,),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Container(
                height: 1,
                width: 293,
                color: Colors.grey[300],
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: 293, //same with line
                height: 30,
                child: Text(
                  recruiting,
                  style: InterviewRecruitingStyle,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(
                    height: 18,
                    child: Text(
                      onlyOnline ? '비대면/대면 | ' : '온라인 | ',
                      style: InterviewOnlyOnlineStyle,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    child: Text(
                      hourlyRate,
                      style: InterviewHourlyRateStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
