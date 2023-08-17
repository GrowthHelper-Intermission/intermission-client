import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/layout/default_layout.dart';
import 'package:intermission_project/common/view/setting/password_change_screen.dart';
import 'package:intermission_project/common/view/setting/personal_info.dart';
import 'package:intermission_project/common/view/setting/rule_exlpain_screen.dart';
import 'package:intermission_project/common/view/setting/version_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alarm_setting_screen.dart';
import 'cancel_member.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '설정',
      child: Column(
        children: [
          SettingComponent(
            title: '비밀번호 찾기',
            otherScreen: PasswordChangeScreen(),
          ),
          SettingComponent(
            title: '알림 설정',
            otherScreen: AlarmSettingScreen(),
          ),
          LogoutSettingComponent(
            title: '로그 아웃',
          ),
          SettingComponent(
            title: '이용 약관',
            otherScreen: RuleExplainScreen(),
          ),
          SettingComponent(
            title: '개인정보처리방침',
            otherScreen: PersonalInfo(),
          ),
          SettingComponent(
            title: '버전 정보',
            otherScreen: VersionInfo(),
          ),
          SettingComponent(
            title: '회원 탈퇴',
            otherScreen: CancelMember(),
          ),
        ],
      ),
    );
  }
}

class SettingComponent extends StatelessWidget {
  final String title;
  final Widget otherScreen;
  const SettingComponent({
    required this.title,
    required this.otherScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => otherScreen),
          );
        },
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class LogoutSettingComponent extends ConsumerWidget {
  final String title;
  const LogoutSettingComponent({
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('로그 아웃'),
                content: Text('로그아웃 하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, '아니오');
                    },
                    child: Text('아니오'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, '예');
                    },
                    child: Text('예'),
                  ),
                ],
              );
            },
          ).then((value) {
            if (value == '예') {
              // logout(context);
              ref.read(userMeProvider.notifier).logout();
            }
          });
        },
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  // Future<void> logout(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('autoLogin', false);
  //   Navigator.pushNamedAndRemoveUntil(
  //     context,
  //     '/',
  //         (route) => false,
  //   );
  // }
}