import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/my_page_screen.dart';
import 'package:intermission_project/01.user/user/view/shopping_screen.dart';
import 'package:intermission_project/04.research/research/view/matching_screen.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:provider/provider.dart';

class RootTab extends StatefulWidget {
  static String get routeName => '/';
  const RootTab({
    Key? key,
  }) : super(key: key);

  @override
  _RootTabState createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;

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
          ShoppingScreen(),
          MatchingScreen(),
          HomeScreen(tabController: _tabController),
          ResearchScreen(),
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
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        items: tabItems.map((tab) {
          bool isSelected = _currentIndex == tabItems.indexOf(tab);
          return BottomNavigationBarItem(
            icon: isSelected && tab.selectedIconPath != null
                ? SvgPicture.asset(
              tab.selectedIconPath!,
              width: 24,
              height: 24,
              color: PRIMARY_COLOR, // 선택된 아이템의 색상
            )
                : SvgPicture.asset(
              tab.iconPath,
              width: 24,
              height: 24,
              color: isSelected ? PRIMARY_COLOR : Colors.grey[600], // 선택되지 않은 아이템의 색상
            ),
            label: tab.label,
          );
        }).toList(),
      ),
    );
  }
}