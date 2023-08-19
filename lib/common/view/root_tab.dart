import 'package:flutter/material.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/matching_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_detail_test_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_screen.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/my_page_screen.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:provider/provider.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({
    Key? key,
  }) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2; // Set the initial selected tab index to 2 (the "홈" tab)

  @override
  void initState() {
    _tabController = TabController(
      length: tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    _tabController.addListener(tabListener);
    super.initState();
  }

  //tap 위치도 스크린 따라가게끔
  void tabListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(), // Disable swiping between tabs
        children: <Widget>[
          TabContentWidget(label: '쇼핑몰'),
          MatchingScreen(),
          HomeScreen(tabController: _tabController),
          InterviewScreen(),
          MyPageScreen(tabController: _tabController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          {
            setState(() {
              _currentIndex = index;
              _tabController.animateTo(index);
            });
          }
        },
        unselectedItemColor: Colors.grey[600], // Set unselected item color
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        items: tabItems.map((tab) {
          return BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == tabItems.indexOf(tab)
                  ? tab.selectedPath ?? tab.iconPath
                  : tab.iconPath,
              width: 24,
              height: 24,
            ),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}

class TabContentWidget extends StatelessWidget {
  final String label;

  const TabContentWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    // Replace this with the content you want to display for each tab
    return Center(
      child: Text(label),
    );
  }
}
