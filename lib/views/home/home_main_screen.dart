import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/tabbar_using_controller.dart';
import 'package:intermission_project/common/const/interviews.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/user/friend_invite_screen.dart';
import 'package:intermission_project/views/home/home_appbar.dart';
import 'package:intermission_project/views/home/home_bottom_button.dart';
import 'package:intermission_project/views/home/home_ongoing_interview_header.dart';
import 'package:intermission_project/user/interview_collection_screen.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/user/matching_screen.dart';
import 'package:intermission_project/user/notice_card.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/views/home/home_ongoing_interview_list.dart';

// class HomeScreen extends StatefulWidget {
//   final PageController? pageController;
//   HomeScreen({this.pageController});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   int pointNumber = 1000;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: HomeAppBar(pointNumber: this.pointNumber),
//       body: Container(
//         color: Colors.white12,
//         child: Center(
//           child: Column(
//             children: [
//               //공지
//               NoticeCard(
//                 notice: '투표 이미지 업로드 테스트를 시작해요~!',
//                 noticeContent: '이미지 업로드 가이드 라인',
//               ),
//               //진행중인 인터뷰 레이블 - More 텍스트 버튼
//               OngoingInterviewHeader(
//                 onMorePressed: () {
//                   widget.pageController?.animateToPage(
//                     3,
//                     duration: Duration(milliseconds: 100),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//               ),
//               //각 InterviewCard
//               OngoingInterviewList(interviews: interviews),
//               //찬구 초대 버튼까지
//               SizedBox(height: 5,),
//               Align(
//                 alignment: Alignment.center,
//                 child: HomeBottomButton(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FriendInviteScreen(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: TabBarController(),
//     );
//   }
// }


class HomeScreen extends StatelessWidget {
  final PageController? pageController;
  HomeScreen({this.pageController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: Center(
        child: Column(
          children: [
            //공지
            NoticeCard(
              notice: '투표 이미지 업로드 테스트를 시작해요~!',
              noticeContent: '이미지 업로드 가이드 라인',
            ),
            //진행중인 인터뷰 레이블 - More 텍스트 버튼
            OngoingInterviewHeader(
              onMorePressed: () {
                pageController?.animateToPage(
                  3,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              },
            ),
            //각 InterviewCard
            OngoingInterviewList(interviews: interviews),
            //찬구 초대 버튼까지
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.center,
              child: HomeBottomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendInviteScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
