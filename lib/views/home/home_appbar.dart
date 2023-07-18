import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/main_tab_controller.dart';
import 'package:intermission_project/views/setting/setting_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int pointNumber;
  final String userName;

  const HomeAppBar({required this.pointNumber,required this.userName, super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //centerTitle: true,
      automaticallyImplyLeading: false, //홈앱바이므로
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Row(
        children: [
          Expanded(
            child: Image.asset('assets/img/intermissionLogo.png',
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
                  userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
