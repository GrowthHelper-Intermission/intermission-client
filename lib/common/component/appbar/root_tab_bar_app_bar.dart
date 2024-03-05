import 'package:flutter/material.dart';

import '../../view/setting_screen.dart';

class RootTabBarAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Color? color;
  final String? title;
  final bool? automaticallyImplyLeading;
  const RootTabBarAppBar({this.color, this.automaticallyImplyLeading, this.title, super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: color ?? Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
            icon: Image.asset(
              'assets/img/Setting.png',
              width: 45,
              height: 45,
              color: Colors.white,
            ),
          ),
        ],
      ),
      foregroundColor: Colors.black,
    );
  }
}
