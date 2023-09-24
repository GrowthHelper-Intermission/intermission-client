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
      label: '포인트 교환',
      iconPath: 'assets/tabimg/ShoppingBag.png',
      selectedPath: 'assets/tabimg/ShoppingBag2.png'),
  TabItem(label: '리서치 의뢰', iconPath: 'assets/tabimg/HandHeart.png'),
  TabItem(
      label: '홈',
      iconPath: 'assets/tabimg/Home.png',
      selectedPath: 'assets/tabimg/Home2.png'),
  TabItem(
      label: '리서치 모음',
      iconPath: 'assets/tabimg/AddressBook.png',
      selectedPath: 'assets/tabimg/AddressBook2.png'),
  TabItem(
      label: 'MY',
      iconPath: 'assets/tabimg/User.png',
      selectedPath: 'assets/tabimg/User2.png'),
];

class MyPageTabItem {
  final String label;
  final String iconPath;

  const MyPageTabItem({
    required this.label,
    required this.iconPath,
  });
}

const List<MyPageTabItem> myPageTabItems = [
  MyPageTabItem(
    label: '참여한 인터뷰',
    iconPath: 'assets/tabimg/mypage/interview.png',
  ),
  MyPageTabItem(
    label: '스크랩',
    iconPath: 'assets/tabimg/mypage/scrap.png',
  ),
  MyPageTabItem(
    label: '매칭 요청',
    iconPath: 'assets/tabimg/mypage/HandHeartBlack.png',
  ),
];

// MyPageTabItem(
//   label: '포인트 적립 내역',
//   iconPath: 'assets/tabimg/mypage/pointCount.png',
// ),
// MyPageTabItem(
//   label: '공지 사항',
//   iconPath: 'assets/tabimg/mypage/notification.png',
// ),
// MyPageTabItem(
//   label: '문의하기',
//   iconPath: 'assets/tabimg/mypage/askInfo.png',
// ),
// MyPageTabItem(
//   label: '친구 추천',
//   iconPath: 'assets/tabimg/mypage/recommendFriend.png',
// ),
