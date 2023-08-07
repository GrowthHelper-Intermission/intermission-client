// import 'package:flutter/material.dart';
// import 'package:intermission_project/common/component/custom_appbar.dart';
// import 'package:intermission_project/common/component/friend_button.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/common/view//default_layout.dart';
// import 'package:intermission_project/models/user.dart';
//
// class FriendInviteScreen extends StatelessWidget {
//   const FriendInviteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     LoginUserProvider user;
//
//     return DefaultLayout(
//       title: '친구 초대',
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Container(
//               width: 340,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 border: Border.all(
//                   width: 1.0,
//                   color: Colors.white12,
//                 ),
//                 borderRadius: BorderRadius.circular(5), // 모서리를 깎는 부분
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '친구에게 추천하면',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         SizedBox(height: 5),  // 간격을 둡니다.
//                         Text(
//                           '두 분 모두 적립금을 드립니다.',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Image.asset(
//                       'assets/img/money.png',
//                       width: 40,
//                       height: 42,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           FriendButton(
//             text: '친구 추천 링크 복사',
//             imageAsset: 'assets/img/link.png',
//             color: SUB_COLOR2,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 30),
//             child: FriendButton(
//               text: '카톡으로 친구 초대',
//               imageAsset: 'assets/img/kakao.png',
//               color: YELLOW_COLOR,
//             ),
//           ),
//           Divider(color: Colors.grey[200], thickness: 12.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(
//                   '친구 추천 현황',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         '가입한 친구'
//                     ),
//                     Text(
//                       '총 0명',
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   height: 1,
//                   width: 350,
//                   color: Colors.grey[200],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                         '이번달에 가입한 친구'
//                     ),
//                     Text(
//                       '0명',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }