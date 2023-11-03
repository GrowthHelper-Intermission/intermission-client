import 'package:flutter/material.dart';
//png 방식
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

// svg
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
    selectedIconPath: 'assets/tabimg/HandHeart2.svg',
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

const List<TabItem> cashItems = [
  TabItem(
    label: '현금 교환',
    iconPath: 'assets/img/cash.svg',
  ),
  TabItem(
    label: '현금 교환',
    iconPath: 'assets/img/cash.svg',
  ),
  TabItem(
    label: '현금 교환',
    iconPath: 'assets/img/cash.svg',
  ),
  TabItem(
    label: '현금 교환',
    iconPath: 'assets/img/cash.svg',
  ),
];

const List<TabItem> myPageTabItems = [
  TabItem(
    label: '참여한 인터뷰',
    iconPath: 'assets/tabimg/mypage/joined.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '스크랩',
    iconPath: 'assets/tabimg/mypage/scrap.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '매칭 요청',
    iconPath: 'assets/tabimg/mypage/request.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '포인트 적립 내역',
    iconPath: 'assets/tabimg/mypage/Coin.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '공지사항',
    iconPath: 'assets/tabimg/mypage/alarm.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '친구 추천',
    iconPath: 'assets/tabimg/mypage/memberPlus.svg', // .png를 .svg로 변경
  ),
  TabItem(
    label: '문의하기',
    iconPath: 'assets/tabimg/mypage/help.svg', // .png를 .svg로 변경
  ),
];