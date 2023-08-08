import 'package:flutter/material.dart';
import 'package:intermission_project/01.user/user/view/user_point_count_screen.dart';
import 'package:intermission_project/01.user/user/view/user_recommend_friend_screen.dart';
import 'package:intermission_project/01.user/user/view/user_report_screen.dart';
import 'package:intermission_project/01.user/user/view/user_scrap_interview_screen.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/view/notices.dart';

class MyPageScreen extends StatelessWidget {
  final TabController tabController;

  const MyPageScreen({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(
        title: 'My PAGE',
      ),
      backgroundColor: Colors.white,
      body: Column(
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
                        '될거야',
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
                          // 참여한 인터뷰 클릭 이벤트를 처리하세요.
                        },
                        child: SizedBox(
                          width: 80,
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
                              Text('참여한 인터뷰'),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // 스크랩 클릭 이벤트를 처리하세요.랩
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScrapInterviews(),),
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
                          tabController.animateTo(1); // MatchingScreen이 있는 인덱스로 탭 이동
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
                  otherScreen: Notices(),
                  icon: 'assets/tabimg/mypage/notification.png',
                ),
                Container(
                  color: Colors.grey[900],
                  height: 0.1,
                ),
                SettingComponent(
                  title: '문의하기',
                  otherScreen: askInfo(),
                  icon: 'assets/tabimg/mypage/askInfo.png',
                ),
                Container(
                  color: Colors.grey[900],
                  height: 0.1,
                ),
                SettingComponent(
                  title: '친구 추천',
                  otherScreen: RecommendFriend(),
                  icon: 'assets/tabimg/mypage/recommendFriend.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        leading: Image.asset(icon,width: 30,height: 30,), // 이미지를 이용하여 아이콘 추가
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Image.asset('assets/img/forwardArrow.png',width: 30,height: 30,color: Colors.grey[600],), // 오른쪽 화살표 아이콘 추가
      ),
    );
  }
}



