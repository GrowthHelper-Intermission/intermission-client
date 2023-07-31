import 'package:flutter/material.dart';
// import 'package:intermission_project/common/component/custom_appbar.dart';
// import 'package:intermission_project/common/component/root_tab.dart';
// import 'package:intermission_project/common/const/interviews.dart';
// import 'package:intermission_project/common/const/tabs.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/user/friend_invite_screen.dart';
// import 'package:intermission_project/views/home/home_appbar.dart';
// import 'package:intermission_project/views/home/home_bottom_button.dart';
// import 'package:intermission_project/views/home/home_ongoing_interview_header.dart';
// import 'package:intermission_project/user/research_collection_screen.dart';
// import 'package:intermission_project/views/login/login_screen.dart';
// import 'package:intermission_project/user/matching_screen.dart';
// import 'package:intermission_project/views/home/home_notice_card.dart';
// import 'package:intermission_project/common/component/custom_text_style.dart';
// import 'package:intermission_project/views/home/home_ongoing_interview_list.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;

  const DefaultLayout({
    this.backgroundColor,
    required this.child,
    this.title,
    this.bottomNavigationBar,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
