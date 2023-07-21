import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';

// final List<Map<String, dynamic>> interviews = [
//   {
//     'interviewId': '뇌졸증 환자 및 보호자 설문 모집', // title과 똑같게
//     'interviewDate': '2023-07-27', //실제 인터뷰 날짜를 입력
//     'color': SUB_BLUE_COLOR,
//     'title': '뇌졸증 환자 및 보호자 설문 모집',
//     'recruiting': '온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능',
//     'onlyOnline': false,
//     'hourlyRate': '1시간 2만원',
//   },

class InterviewModel{
  final String interviewId;
  final String interviewDate;
  final String title;
  final String recruiting;
  final eonlineAndOffline;
  final String hourlyRate;
  final String requester;

}