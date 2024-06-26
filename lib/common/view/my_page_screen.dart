import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/notice/view/notice_screen.dart';
import 'package:intermission_project/common/component/appbar/root_tab_bar_app_bar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/intermission_screen.dart';
import 'package:intermission_project/point/view/point_history_screen.dart';
import 'package:intermission_project/report/view/report_screen.dart';
import 'package:intermission_project/common/view/friend_invite_screen.dart';
import 'package:intermission_project/user/model/user_model.dart';
import 'package:intermission_project/user/provider/user_me_provider.dart';
import 'package:intermission_project/user/view/completed/partcipated_research_screen.dart';

import '../../user/view/completed/scraped_research_screen.dart';

class MyPageScreen extends ConsumerWidget {
  final TabController tabController;

  const MyPageScreen({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userMeProvider); // 상태를 읽어옴
    UserModel? user; // UserModel을 nullable로 선언

    if (userState is UserModel) {
      user = userState; // UserModel로 캐스팅
    }

    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: RootTabBarAppBar(
          title: '마이 페이지',
          color: PRIMARY_COLOR,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: SvgPicture.asset(
                          'assets/img/circle/userColor.svg',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            user!.userName!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                  ParticipatedResearchScreen.routeName);
                            },
                            child: SizedBox(
                              width: 85,
                              height: 80,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/tabimg/mypage/joined.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('참여한 리서치'),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .pushNamed(ScrapedResearchScreen.routeName);
                            },
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/tabimg/mypage/scrap.svg',
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey[800], // SVG 이미지에 적용할 색상
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('스크랩'),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              tabController
                                  .animateTo(1); // MatchingScreen이 있는 인덱스로 탭 이동
                            },
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/tabimg/mypage/request.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('매칭 요청'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[200], thickness: 12.0),
              Container(
                child: Column(
                  children: [
                    SettingComponent(
                      title: '포인트 적립 내역',
                      otherScreen: PointHistoryScreen(),
                      icon: 'assets/tabimg/mypage/Coin.svg', // .png에서 .svg로 변경
                    ),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '공지사항',
                      otherScreen: NoticeScreen(),
                      icon: 'assets/tabimg/mypage/alarm.svg', // .png에서 .svg로 변경
                    ),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '문의하기',
                      otherScreen: UserReportScreen(),
                      icon: 'assets/tabimg/mypage/help.svg', // .png에서 .svg로 변경
                    ),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '친구 추천',
                      otherScreen: FriendInviteScreen(),
                      icon: 'assets/tabimg/mypage/memberPlus.svg',
                    ),
                    // 관리자 페이지 아이콘도 필요한 경우 SVG로 변경하세요.
                    // SettingComponent(
                    //   title: '관리자 페이지',
                    //   otherScreen: AdminPage(),
                    //   icon: 'assets/tabimg/mypage/Link.svg',
                    // ),
                    Divider(color: Colors.grey[200], thickness: 12.0),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntermissionScreen()),
                        );
                      },
                      title: Text(
                        '인터미션 정보',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: svgIcon(
                        'assets/img/forwardArrow.svg',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class SettingComponent extends StatelessWidget {
  final String title;
  final Widget otherScreen;
  final String icon;

  SettingComponent({
    required this.title,
    required this.otherScreen,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => otherScreen),
          );
        },
        leading: svgIcon(icon), // Updated to use svgIcon function
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: svgIcon('assets/img/forwardArrow.svg',
            color: Colors.grey[600]), // Updated to use svgIcon function
      ),
    );
  }
}

Widget svgIcon(String assetName,
    {double width = 30, double height = 30, Color? color}) {
  return SvgPicture.asset(
    assetName,
    width: width,
    height: height,
    color: color,
  );
}
