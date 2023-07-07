import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/home/home_appbar.dart';
import 'package:intermission_project/user/interview_collection_screen.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/user/matching_screen.dart';
import 'package:intermission_project/views/home/home_main_screen.dart';
// import 'package:flutter/rendering.dart'; //PNG아이콘 색상변경

// class TabUsingController extends StatefulWidget {
//   @override
//   _TabUsingControllerState createState() => _TabUsingControllerState();
// }
//
// class _TabUsingControllerState extends State<TabUsingController>
//     with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController(initialPage: 2);
//   int _currentIndex =
//       2; // Set the initial selected tab index to 2 (the "홈" tab)
//   int pointNumber = 1000;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         children: <Widget>[
//           TabContentWidget(label: '쇼핑몰'),
//           MatchingScreen(),
//           HomeScreen(pageController: _pageController),
//           InterviewCollectionScreen(),
//           HomeScreen(pageController: _pageController),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: PRIMARY_COLOR,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           // if (index == 1) {
//           //   Navigator.push(context,
//           //       MaterialPageRoute(builder: (context) => MatchingScreen()));
//           // }
//           if (index == 4) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LoginScreen(),
//               ),
//             );
//           } else {
//             _pageController.animateToPage(
//               index,
//               duration: Duration(milliseconds: 100),
//               curve: Curves.easeInOut,
//             );
//           }
//         },
//         unselectedItemColor: Colors.grey[600], // Set unselected item color
//         selectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         unselectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         items: tabItems.map((tab) {
//           return BottomNavigationBarItem(
//             icon: Image.asset(
//               _currentIndex == tabItems.indexOf(tab)
//                   ? tab.selectedPath ?? tab.iconPath
//                   : tab.iconPath,
//               width: 24,
//               height: 24,
//             ),
//             label: tab.label,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// class TabBarController extends StatefulWidget {
//   const TabBarController({super.key});
//
//   @override
//   State<TabBarController> createState() => _TabBarControllerState();
// }
//
// class _TabBarControllerState extends State<TabBarController> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(items: [],
//     );
//   }
// }
//
//
// class TabContentWidget extends StatelessWidget {
//   final String label;
//
//   const TabContentWidget({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with the content you want to display for each tab
//     return Center(
//       child: Text(label),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/user/matching_screen.dart';

// class TabBarController extends StatefulWidget {
//   @override
//   _TabBarControllerState createState() => _TabBarControllerState();
// }
//
// class _TabBarControllerState extends State<TabBarController>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 2; // Set the initial selected tab index to 2 (the "홈" tab)
//
//   @override
//   void initState() {
//     _tabController = TabController(length: tabItems.length, vsync: this, initialIndex: _currentIndex);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         physics: NeverScrollableScrollPhysics(), // Disable swiping between tabs
//         children: <Widget>[
//           TabContentWidget(label: '쇼핑몰'),
//           MatchingScreen(),
//           HomeScreen(),
//           InterviewCollectionScreen(),
//           LoginScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: PRIMARY_COLOR,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           if (index == 4) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LoginScreen(),
//               ),
//             );
//           } else {
//             setState(() {
//               _currentIndex = index;
//               _tabController.animateTo(index);
//             });
//           }
//         },
//         unselectedItemColor: Colors.grey[600], // Set unselected item color
//         selectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         unselectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         items: tabItems.map((tab) {
//           return BottomNavigationBarItem(
//             icon: Image.asset(
//               _currentIndex == tabItems.indexOf(tab)
//                   ? tab.selectedPath ?? tab.iconPath
//                   : tab.iconPath,
//               width: 24,
//               height: 24,
//             ),
//             label: tab.label,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class TabContentWidget extends StatelessWidget {
//   final String label;
//
//   const TabContentWidget({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with the content you want to display for each tab
//     return Center(
//       child: Text(label),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/views/home/home_appbar.dart';
import 'package:intermission_project/user/interview_collection_screen.dart';
import 'package:intermission_project/views/login/login_screen.dart';
import 'package:intermission_project/user/matching_screen.dart';
import 'package:intermission_project/views/home/home_main_screen.dart';

class TabBarController extends StatefulWidget {
  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2; // Set the initial selected tab index to 2 (the "홈" tab)
  int pointNumber = 1000;

  @override
  void initState() {
    _tabController = TabController(
      length: tabItems.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(pointNumber: this.pointNumber),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(), // Disable swiping between tabs
        children: <Widget>[
          TabContentWidget(label: '쇼핑몰'),
          MatchingScreen(),
          HomeScreen(),
          InterviewCollectionScreen(),
          LoginScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          } else {
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


// import 'package:flutter/material.dart';
// import 'package:intermission_project/common/const/tabs.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:intermission_project/views/login/login_screen.dart';
// import 'package:intermission_project/user/matching_screen.dart';
//
// class TabBarController extends StatefulWidget {
//   @override
//   _TabBarControllerState createState() => _TabBarControllerState();
// }
//
// class _TabBarControllerState extends State<TabBarController>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   int pointNumber = 1000;
//   int currentIndex = 2; // Set the initial selected tab index to 2 (the "홈" tab)
//
//   @override
//   void initState() {
//     tabController = TabController(
//       length: tabItems.length,
//       vsync: this,
//       initialIndex: currentIndex,
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: HomeAppBar(
//         pointNumber: this.pointNumber,
//       ),
//       body: TabBarView(
//         controller: tabController,
//         physics: NeverScrollableScrollPhysics(), // Disable swiping between tabs
//         children: <Widget>[
//           TabContentWidget(label: '쇼핑몰'),
//           MatchingScreen(),
//           HomeScreen(),
//           InterviewCollectionScreen(),
//           LoginScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: PRIMARY_COLOR,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         onTap: (index) {
//           if (index == 4) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => LoginScreen(),
//               ),
//             );
//           } else {
//             setState(() {
//               currentIndex = index;
//               tabController.animateTo(index);
//             });
//           }
//         },
//         unselectedItemColor: Colors.grey[600], // Set unselected item color
//         selectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         unselectedLabelStyle: TextStyle(
//           fontSize: 10,
//           fontWeight: FontWeight.w400,
//         ),
//         items: tabItems.map((tab) {
//           return BottomNavigationBarItem(
//             icon: Image.asset(
//               currentIndex == tabItems.indexOf(tab)
//                   ? tab.selectedPath ?? tab.iconPath
//                   : tab.iconPath,
//               width: 24,
//               height: 24,
//             ),
//             label: tab.label,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class TabContentWidget extends StatelessWidget {
//   final String label;
//
//   const TabContentWidget({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with the content you want to display for each tab
//     return Center(
//       child: Text(label),
//     );
//   }
// }
