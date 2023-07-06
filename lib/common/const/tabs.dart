import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final String iconPath;
  final String? selectedPath;

  const TabItem(
      {this.selectedPath, required this.label, required this.iconPath});
}

const List<TabItem> tabItems = [
  TabItem(
      label: '쇼핑몰',
      iconPath: 'assets/tabimg/ShoppingBag.png',
      selectedPath: 'assets/tabimg/ShoppingBag2.png'
  ),
  TabItem(label: '매칭 요청',
      iconPath: 'assets/tabimg/HandHeart.png'
  ),
  TabItem(
      label: '홈',
      iconPath: 'assets/tabimg/Home.png',
      selectedPath: 'assets/tabimg/Home2.png'
  ),
  TabItem(
      label: '인터뷰 모음',
      iconPath: 'assets/tabimg/AddressBook.png',
      selectedPath: 'assets/tabimg/AddressBook2.png'
  ),
  TabItem(
      label: 'MY',
      iconPath: 'assets/tabimg/User.png',
      selectedPath: 'assets/tabimg/User2.png'
  ),
];

