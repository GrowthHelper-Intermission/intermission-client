import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/home/home_appbar.dart';
import 'package:intermission_project/user/interview_collection_screen.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/user/matching_screen.dart';
import 'package:intermission_project/views/home/home_main_screen.dart';
// import 'package:flutter/rendering.dart'; //PNG아이콘 색상변경

class TabUsingController extends StatefulWidget {
  @override
  _TabUsingControllerState createState() => _TabUsingControllerState();
}

class _TabUsingControllerState extends State<TabUsingController>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 2);
  int _currentIndex =
      2; // Set the initial selected tab index to 2 (the "홈" tab)
  int pointNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: HomeAppBar(pointNumber: this.pointNumber),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          TabContentWidget(label: '쇼핑몰'),
          MatchingScreen(),
          MainScreen(pageController: _pageController),
          InterviewCollectionScreen(),
          MainScreen(pageController: _pageController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          // if (index == 1) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => MatchingScreen()));
          // }
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          } else {
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
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




