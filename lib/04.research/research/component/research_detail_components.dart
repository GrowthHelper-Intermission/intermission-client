import 'package:flutter/material.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/component/date_display_box.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';

/// 완료
Widget researchBuildHeader(ResearchDetailModel state,int daysLeft) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        _mapResearchTypeToText(state.researchType),
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      DateDisplayWidget(daysLeft: daysLeft),
    ],
  );
}

/// mainTitle~온라인|2시간30분까지
Widget researchBuildMainContent(ResearchDetailModel state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 5),
      Text(state.mainTitle, style: customTextStyle),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(state.subTitle, style: whiteSmallTextStyle),
          Text(state.researchRewdPoint!, style: blueSmallTextStyle,),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Text(state.researchMethTpCd, style: whiteSmallTextStyle),
          Text(' | ', style: whiteSmallTextStyle),
          Text('${state.exceptTime}시간 ', style: whiteSmallTextStyle),
          Text(state.researchRewdAmt, style: whiteSmallTextStyle),
        ],
      ),
      SizedBox(height: 5),
      _buildInfoContainer(state),
      _buildParticipationInfo(state),
    ],
  );
}

///소요시간~모집인원
Widget _buildInfoContainer(ResearchDetailModel state) {
  return Center(
    child: Container(
      width: 355,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey.shade200,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowInfo('소요시간', '${state.exceptTime}시간'),
          _buildRowInfo('마감일', state.dueDate),
          _buildRowInfo('대상', state.minAge),
          _buildRowInfo('모집 인원', state.researchEntryCnt),
        ],
      ),
    ),
  );
}

///소요시간~모집인원의 각각의 ROW
Widget _buildRowInfo(String title, String value) {
  const double titleWidth = 80.0;
  const double valueWidth = 220.0;

  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 20, 5),
    child: Row(
      children: [
        Container(
          width: titleWidth,
          child: Text(title, style: whiteBlueTextStyle),
        ),
        Expanded(
            child: SizedBox.shrink()), // to push the next text to the end
        Container(
          width: valueWidth,
          child: Text(value, style: TextStyle(fontSize: 12)),
        ),
      ],
    ),
  );
}

///현재 x명이 참여했어요!
Widget _buildParticipationInfo(ResearchDetailModel state) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '현재 ', style: whiteMiddleTextStyle),
              TextSpan(
                text: '${state.researchCnt}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '명이 참여했어요!', style: whiteMiddleTextStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

///설명
Widget researchBuildDescription(ResearchDetailModel state) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '설명',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          state.detail,
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}


String _mapResearchTypeToText(String researchType) {
  switch (researchType) {
    case 'survey':
      return '설문조사';
    case 'interview':
      return '인터뷰';
    case 'test':
      return '테스트 참여';
    default:
      return researchType;
  }
}