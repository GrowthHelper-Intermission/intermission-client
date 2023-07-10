import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/layout/default_layout.dart';
import 'package:intermission_project/views/setting/alarm_setting_screen.dart';
import 'package:intermission_project/views/setting/cancel_member.dart';
import 'package:intermission_project/views/setting/logout_screen.dart';
import 'package:intermission_project/views/setting/password_change_screen.dart';
import 'package:intermission_project/views/setting/personal_info.dart';
import 'package:intermission_project/views/setting/rule_explain_screen.dart';
import 'package:intermission_project/views/setting/version_info.dart';

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
          SettingComponent(
            title: '로그 아웃',
            otherScreen: LogoutScreen(),
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
  String title;
  Widget otherScreen;
  SettingComponent({
    required this.title,
    required this.otherScreen,
    super.key,
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
        trailing: Icon(Icons.arrow_forward_ios), // 오른쪽 화살표 아이콘 추가
      ),
    );
  }
}
