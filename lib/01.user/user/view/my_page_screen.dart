import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/etc/friend_invite_screen.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/user_partcipated_research_screen.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/01.user/user/view/user_recommend_friend_screen.dart';
import 'package:intermission_project/01.user/user/view/user_report_screen.dart';
import 'package:intermission_project/01.user/user/view/user_scrap_interview_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_req_screen.dart';
import 'package:intermission_project/04.research/research/view/notice_screen.dart';
import 'package:intermission_project/04.research/research_req/view/research_req_screen.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';


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
        appBar: NormalAppbar(
          title: 'My PAGE',
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
                        child: Image.asset('assets/img/userColor.png'),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ParticipatedResearchScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 85,
                              height: 80,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/tabimg/mypage/interview.png',
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey[800],
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScrapedResearchScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/tabimg/mypage/scrap.png',
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey[800],
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
                                  Image.asset(
                                    'assets/tabimg/mypage/HandHeartBlack.png',
                                    width: 40,
                                    height: 40,
                                    color: Colors.grey[800],
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
                      otherScreen: PointCount(),
                      icon: 'assets/tabimg/mypage/pointCount.png',
                    ),
                    //Divider(color: Colors.grey[400], thickness: 0.5),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '공지사항',
                      otherScreen: NoticeScreen(),
                      icon: 'assets/tabimg/mypage/notification.png',
                    ),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '문의하기',
                      otherScreen: UserReportScreen(),
                      icon: 'assets/tabimg/mypage/askInfo.png',
                    ),
                    Container(
                      color: Colors.grey[900],
                      height: 0.1,
                    ),
                    SettingComponent(
                      title: '친구 추천',
                      otherScreen: FriendInviteScreen(),
                      icon: 'assets/tabimg/mypage/recommendFriend.png',
                    ),
                    SettingComponent(
                      title: '관리자 페이지',
                      otherScreen: AdminPage(),
                      icon: 'assets/img/link.png',
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
  final String icon; // 아이콘 경로를 받을 변수 추가
  SettingComponent({
    required this.title,
    required this.otherScreen,
    required this.icon, // required로 icon 파라미터 추가
    Key? key, // super.key를 Key? key로 수정
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
        leading: Image.asset(
          icon,
          width: 30,
          height: 30,
        ), // 이미지를 이용하여 아이콘 추가
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Image.asset(
          'assets/img/forwardArrow.png',
          width: 30,
          height: 30,
          color: Colors.grey[600],
        ), // 오른쪽 화살표 아이콘 추가
      ),
    );
  }
}


class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('관리자 페이지')),
      body: Column(
        children: [
          SettingComponent(
            title: '리서치 게시하기',
            otherScreen: ResearchReqScreen(),
            icon: 'assets/tabimg/mypage/recommendFriend.png',
          ),
          SettingComponent(
            title: '공지사항 게시하기',
            otherScreen: NotiReqScreen(),
            icon: 'assets/tabimg/mypage/recommendFriend.png',
          ),
        ],
      ),
    );
  }
}
