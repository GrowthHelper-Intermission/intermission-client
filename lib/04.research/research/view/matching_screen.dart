import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(title: '리서치 의뢰',),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩 추가
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomButton(
              onPressed: () => _launchURL('https://docs.google.com/forms/d/e/1FAIpQLScpInA5ldhmSqRSZjw8By71xaZkYoq2thsUlM4eXhEV9ELrMA/viewform'),
              buttonName: '인터뷰 의뢰하기',
            ),
            _buildCustomButton(
              onPressed: () => _launchURL('https://docs.google.com/forms/d/e/1FAIpQLSc6k65N6yNbnTBNN4oHg6A0e_2hrucjMSfkEl3jdTANGKhUJQ/viewform'),
              buttonName: '설문 의뢰하기',
            ),
            _buildCustomButton(
              onPressed: () => _launchURL('https://docs.google.com/forms/d/e/1FAIpQLSdZuQK4k5Cf1LXSYnbROof0ePo3-kJQctbXS-yxCZPK3ZeLNw/viewform'),
              buttonName: '제품/서비스 테스터 의뢰하기',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required VoidCallback onPressed,
    required String buttonName,
  }) {
    return LoginNextButton(
      onPressed: onPressed,
      buttonName: buttonName,
      isButtonEnabled: true,
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
