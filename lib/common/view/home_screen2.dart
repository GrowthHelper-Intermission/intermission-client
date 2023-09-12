// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intermission_project/01.user/user/etc/friend_invite_screen.dart';
// import 'package:intermission_project/01.user/user/model/point_model.dart';
// import 'package:intermission_project/01.user/user/model/user_model.dart';
// import 'package:intermission_project/01.user/user/provider/point_provider.dart';
// import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
// import 'package:intermission_project/01.user/user/view/select_screen.dart';
// import 'package:intermission_project/04.research/research/component/home_ongoing_research_list.dart';
// import 'package:intermission_project/04.research/research/provider/research_provider.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/common/model/cursor_pagination_model.dart';
// import 'package:intermission_project/common/view/notice_slide.dart';
// import 'package:intermission_project/common/view/setting/setting_screen.dart';
//
// class HomeScreen extends ConsumerStatefulWidget {
//   final TabController? tabController;
//
//   HomeScreen({this.tabController});
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     // ref.read(researchProvider.notifier).paginate();
//     final userState = ref.watch(userMeProvider); // 상태를 읽어옴
//     UserModel? user; // UserModel을 nullable로 선언
//
//     if (userState is UserModel) {
//       user = userState; // UserModel로 캐스팅
//     }
//
//     ref.read(researchProvider.notifier).getTopThreeResearches();
//
//     final userPointState = ref.watch(pointProvider);
//     int point = 0;
//
//     if(userPointState is CursorPagination<PointModel>){
//       point = userPointState.meta.totalPoint!;
//     }
//
//     // // user 또는 userPointState가 로딩 중일 때 로딩 인디케이터를 표시
//     // if (user == null || userPointState is CursorPaginationLoading) {
//     //   print('halla');
//     //   return Center(
//     //     child: CircularProgressIndicator(),
//     //   );
//     // }
//
//     // if (user == null || userPointState is CursorPaginationLoading) {
//     //   print('halla');
//     //   // 로딩 상태를 확인하되, 아래의 Scaffold를 반환하여 홈 화면에 진입 가능하게 합니다.
//     // }
//     // else {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Image.asset('assets/img/intermissionLogo.png',
//                   width: 60, height: 38),
//             ),
//             SizedBox(width: 100),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // 사용자 정보가 없는 경우 로그인 버튼을 표시
//                   if (user == null)
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SelectScreen()), // 로그인 화면으로 이동
//                         );
//                       },
//                       child: Text("로그인하기"),
//                     )
//                   else
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             user.userNm!,
//                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                           ),
//                           Text(
//                             '$point P',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SettingScreen()),
//                 );
//               },
//               icon:
//               Image.asset('assets/img/Setting.png', width: 32, height: 32),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: Colors.white12,
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                 width: 350,
//                 height: 84,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 1.0,
//                     color: SUB_COLOR,
//                   ),
//                   color: SUB_COLOR,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child:
//                         Container(
//                           height: 18,
//                           child: Text(
//                             '[공지]',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF9C5EDA),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         // NoticeSlide(),
//                       ),
//                       Expanded(
//                         child: Container(
//                           height: 40,
//                           child: Text(
//                             '투표 이미지 업로드 테스트를 시작해요~!',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 3,
//                       ),
//                       Expanded(
//                         child: Container(
//                           height: 14,
//                           child: Text(
//                             '이미지 업로드 가이드 라인',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w100,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 8, 10, 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '진행 중인 리서치',
//                       style:
//                       TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         widget.tabController?.animateTo(3);
//                       },
//                       child: Text(
//                         'More',
//                         style: TextStyle(
//                           color: SUB_BLUE_COLOR,
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               OngoingResearchList(),
//               // SizedBox(
//               //   height: 5,
//               // ),
//               Align(
//                 alignment: Alignment.center,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FriendInviteScreen(),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
//                     child: Container(
//                       width: 335,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: SUB_BLUE_COLOR,
//                           width: 1.0,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           '친구초대하고 300P받기',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: SUB_BLUE_COLOR,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // }