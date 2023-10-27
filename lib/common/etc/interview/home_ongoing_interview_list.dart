// import 'package:flutter/material.dart';
// import 'package:intermission_project/models/user.dart';
// import 'package:intermission_project/views/interview/home_interview_card.dart';
// import 'package:intermission_project/views/setting/setting_screen.dart';
//
// class OngoingInterviewList extends StatelessWidget {
//   final List<Map<String, dynamic>> interviews;
//
//   const OngoingInterviewList({required this.interviews});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: interviews.length,
//         itemBuilder: (context, index) {
//           final interview = interviews[index];
//           return InterviewCard(
//             interviewId: interview['interviewId'],
//             interviewDate: interview['interviewDate'],
//             color: interview['color'],
//             title: interview['title'],
//             recruiting: interview['recruiting'],
//             onlyOnline: interview['onlyOnline'],
//             hourlyRate: interview['hourlyRate'],
//           );
//         },
//       ),
//     );
//   }
// }