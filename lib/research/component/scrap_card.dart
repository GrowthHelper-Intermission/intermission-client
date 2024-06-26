import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/common/const/text_style.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/research/model/scrap_research_model.dart';
import 'package:intermission_project/research/view/participate/research_detail_screen.dart';

class ScrapResearchCard extends StatefulWidget {
  final int id; // PK
  final String mainTitle; // ex) 뇌졸중 환자 및 보호자
  final String subTitle; //ex) 온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능
  final String dueDate; // yyyy-mm-dd
  final String exceptTime;
  final String researchMethTpCd;
  final String isEligible;

  const ScrapResearchCard({
    required this.id,
    required this.mainTitle,
    required this.subTitle,
    required this.exceptTime,
    required this.researchMethTpCd,
    required this.dueDate,
    required this.isEligible,
    super.key,
  });

  factory ScrapResearchCard.fromModel({
    required ScrapResearchModel model,
    bool isDetail = false,
  }) {
    return ScrapResearchCard(
      id: model.id,
      mainTitle: model.mainTitle,
      subTitle: model.subTitle,
      researchMethTpCd: model.researchMethTpCd,
      exceptTime: model.exceptTime,
      dueDate: model.dueDate,
      isEligible: model.isEligible,
    );
  }

  @override
  State<ScrapResearchCard> createState() => _ResearchCardState();
}

class _ResearchCardState extends State<ScrapResearchCard> {
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
    final screenHeight = MediaQuery.of(context).size.height;

    daysLeft =
        _getDaysLeft(); // Every time the widget is built, update the days left.

    String displayText;
    Color borderColor;
    Color textColor;
    Color backgroundColor;

    Color screeningTextColor;
    Color screeningBackgroundColor;
    Color screeningBorderColor;
    String screeningDisplayText;

    if(widget.isEligible == "PARTICIPATION_POSSIBLE"){
      screeningDisplayText = "참여가능";
      screeningBorderColor = RED_COLOR;
      screeningTextColor = RED_COLOR;
      screeningBackgroundColor = Colors.white;
    }else{
      screeningDisplayText = "참여불가";
      screeningBorderColor = GREY_COLOR;
      screeningTextColor = GREY_COLOR;
      screeningBackgroundColor = Colors.white;
    }

    TextStyle titleStyle = TextStyle(
      color: widget.isEligible == "PARTICIPATION_IMPOSSIBLE" ? Colors.grey : Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    );

    TextStyle subTitleStyle = TextStyle(
      color: widget.isEligible == "PARTICIPATION_IMPOSSIBLE" ? Colors.grey : Colors.black,
      fontSize: 13,
    );

    if (daysLeft > 3) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft > 0) {
      displayText = 'D-$daysLeft';
      borderColor = SUB_BLUE_COLOR;
      textColor = SUB_BLUE_COLOR;
      backgroundColor = Colors.white;
    } else if (daysLeft == 0) {
      displayText = 'D-day';
      borderColor = SUB_BLUE_COLOR;
      textColor = Colors.white;
      backgroundColor = SUB_BLUE_COLOR;
    } else {
      displayText = '마감';
      borderColor = PRIMARY_COLOR;
      textColor = Colors.white;
      backgroundColor = PRIMARY_COLOR;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Card(
        child: InkWell(
          onTap: () {
            context.pushNamed(ResearchDetailScreen.routeName,
                pathParameters: {'id': widget.id.toString()});
          },
          child: Container(
            width: 335,
            height: screenHeight * 0.21,
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
                        width: 45,
                        height: 21,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            displayText,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.mainTitle,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 1),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: screenHeight*0.02),
                  Expanded(
                    child: Text(
                      widget.subTitle,
                      style: subTitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Container(), // This takes up the remaining space
                  ),
                  Row(
                    children: [
                      Text(
                        widget.researchMethTpCd,
                        style: greySmallTextStyle,
                      ),
                      Text(
                        ' | ',
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        '${widget.exceptTime}시간 ',
                        style: blueSmallTextStyle,
                      ),
                      Text(
                        ' | ',
                        style: whiteSmallTextStyle,
                      ),
                      Container(
                        width: 65,
                        height: 21,
                        decoration: BoxDecoration(
                          color: screeningBackgroundColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: screeningBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            screeningDisplayText,
                            style: TextStyle(
                              color: screeningTextColor,
                              fontSize: 13.0,
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
        ),
      ),
    );
  }
}
