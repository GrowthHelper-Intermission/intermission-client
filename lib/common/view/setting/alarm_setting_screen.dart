import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class AlarmSettingScreen extends StatefulWidget {
  const AlarmSettingScreen({super.key});

  @override
  State<AlarmSettingScreen> createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  bool switchValue1 = false; // 스위치 상태를 관리하는 변수
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '알림 설정',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '푸시 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue1,
                    activeColor: PRIMARY_COLOR,
                    onChanged: (bool value) async {
                      if (value) {
                        // 스위치가 켜질 때 권한 요청
                        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
                          alert: true,
                          badge: true,
                          sound: true,
                        );
                        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
                          // 권한이 부여됨
                          print('알림 권한 부여됨');
                        } else {
                          // 권한 거부됨
                          print('알림 권한 거부됨');
                          setState(() {
                            switchValue1 = false; // 스위치 상태를 다시 끔으로 변경
                          });
                        }
                      } else {
                        // 스위치가 꺼질 때 권한 거부 처리 (필요한 경우)
                      }

                      setState(() {
                        switchValue1 = value;
                      });
                    },
                  ),

                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '새로운 리서치 추천 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue2,
                    activeColor: PRIMARY_COLOR,
                    onChanged: (bool value) {
                      setState(() {
                        switchValue2 = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[900],
            thickness: 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '이벤트 알림',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(
                    value: switchValue3,
                    activeColor: PRIMARY_COLOR,
                    onChanged: (bool value) {
                      setState(() {
                        switchValue3 = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '테스트 알림 보내기',
                    style: TextStyle(
                      color: BORDER_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // 여기에 Firebase 테스트 알림 보내기 로직 추가 예정
                      print('테스트 알림 보내기 요청');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.alarm,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 여기에 다른 위젯들 추가 가능
        ],
      ),
    );
  }
}
