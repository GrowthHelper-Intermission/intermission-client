import 'package:flutter/material.dart';

// class TabItem {
//   final String label;
//   final String iconPath;
//   final String? selectedPath;
//
//   const TabItem(
//       {this.selectedPath, required this.label, required this.iconPath});
// }
//
// const List<TabItem> tabItems = [
//   TabItem(
//       label: '포인트 교환',
//       iconPath: 'assets/tabimg/Coins1.svg',
//       selectedPath: 'assets/tabimg/Coins2.svg'),
//   TabItem(label: '리서치 의뢰', iconPath: 'assets/tabimg/HandHeart1.svg'),
//   TabItem(
//       label: '홈',
//       iconPath: 'assets/tabimg/Home1.svg',
//       selectedPath: 'assets/tabimg/Home2.svg'),
//   TabItem(
//       label: '리서치 모음',
//       iconPath: 'assets/tabimg/AddressBook1.svg',
//       selectedPath: 'assets/tabimg/AddressBook2.svg'),
//   TabItem(
//       label: 'MY',
//       iconPath: 'assets/tabimg/User1.svg',
//       selectedPath: 'assets/tabimg/User2.svg'),
// ];
//
// class MyPageTabItem {
//   final String label;
//   final String iconPath;
//
//   const MyPageTabItem({
//     required this.label,
//     required this.iconPath,
//   });
// }
//
// const List<MyPageTabItem> myPageTabItems = [
//   MyPageTabItem(
//     label: '참여한 인터뷰',
//     iconPath: 'assets/tabimg/mypage/interview.png',
//   ),
//   MyPageTabItem(
//     label: '스크랩',
//     iconPath: 'assets/tabimg/mypage/scrap.png',
//   ),
//   MyPageTabItem(
//     label: '매칭 요청',
//     iconPath: 'assets/tabimg/mypage/HandHeartBlack.png',
//   ),
// ];

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabItem {
  final String label;
  final String iconPath;
  final String? selectedIconPath;

  const TabItem({
    required this.label,
    required this.iconPath,
    this.selectedIconPath,
  });

  Widget icon({bool isSelected = false}) {
    final path = isSelected && selectedIconPath != null ? selectedIconPath : iconPath;
    return SvgPicture.asset(
      path!,
      height: 25.0, // 또는 원하는 크기
    );
  }
}

const List<TabItem> tabItems = [
  TabItem(
    label: '포인트 교환',
    iconPath: 'assets/tabimg/Coins1.svg',
    selectedIconPath: 'assets/tabimg/Coins2.svg',
  ),
  TabItem(
    label: '리서치 의뢰',
    iconPath: 'assets/tabimg/HandHeart1.svg',
  ),
  TabItem(
    label: '홈',
    iconPath: 'assets/tabimg/Home1.svg',
    selectedIconPath: 'assets/tabimg/Home2.svg',
  ),
  TabItem(
    label: '리서치 모음',
    iconPath: 'assets/tabimg/AddressBook1.svg',
    selectedIconPath: 'assets/tabimg/AddressBook2.svg',
  ),
  TabItem(
    label: 'MY',
    iconPath: 'assets/tabimg/User1.svg',
    selectedIconPath: 'assets/tabimg/User2.svg',
  ),
];

class MyPageTabItem {
  final String label;
  final String iconPath;

  const MyPageTabItem({
    required this.label,
    required this.iconPath,
  });

  Widget get icon {
    return SvgPicture.asset(
      iconPath,
      height: 25.0, // 또는 원하는 크기
    );
  }
}

const List<MyPageTabItem> myPageTabItems = [
  MyPageTabItem(
    label: '참여한 인터뷰',
    iconPath: 'assets/tabimg/mypage/joined.svg', // .png를 .svg로 변경
  ),
  MyPageTabItem(
    label: '스크랩',
    iconPath: 'assets/tabimg/mypage/scrap.svg', // .png를 .svg로 변경
  ),
  MyPageTabItem(
    label: '매칭 요청',
    iconPath: 'assets/tabimg/mypage/request.svg', // .png를 .svg로 변경
  ),
];


///
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
