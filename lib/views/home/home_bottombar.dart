import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/tabs.dart';
import 'package:intermission_project/common/const/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItemData> tabItems;
  final Function(int) onTabChanged;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.tabItems,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: PRIMARY_COLOR,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTabChanged,
      unselectedItemColor: Colors.grey[600],
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
            currentIndex == tabItems.indexOf(tab)
                ? tab.selectedPath ?? tab.iconPath
                : tab.iconPath,
            width: 24,
            height: 24,
          ),
          label: tab.label,
        );
      }).toList(),
    );
  }
}

class BottomNavigationBarItemData {
  final String label;
  final String iconPath;
  final String? selectedPath;

  BottomNavigationBarItemData({
    required this.label,
    required this.iconPath,
    this.selectedPath,
  });
}
