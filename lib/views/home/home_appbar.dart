import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/user/setting_screen.dart';

// class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final int pointNumber;
//
//   const HomeAppBar({required this.pointNumber, super.key});
//
//   @override
//   Size get preferredSize => Size.fromHeight(60);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       //centerTitle: true,
//       elevation: 0,
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       title: Row(
//         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset(
//             'assets/img/intermission_logo.png',
//             width: 60,
//             height: 38,
//           ),
//           SizedBox(
//             width: 95,
//           ),
//           SizedBox(
//             width: 55,
//             height: 40,
//             child: Column(
//               //crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   '김민지님',
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//                 ),
//                 Text(
//                   '$pointNumber P',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: 105,
//           ),
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SettingScreen()),
//                 );
//               },
//               icon: Image.asset(
//                 'assets/img/Setting.png',
//                 width: 32,
//                 height: 32,
//               )),
//         ],
//       ),
//     );
//   }
// }

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int pointNumber;

  const HomeAppBar({required this.pointNumber, super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Row(
        children: [
          Expanded(
            child: Image.asset('assets/img/intermission_logo.png',
                width: 60, height: 38),
          ),
          SizedBox(width: 100),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '류지원님',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  '$pointNumber P',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
            icon: Image.asset('assets/img/Setting.png', width: 32, height: 32),
          ),
        ],
      ),
    );
  }
}
