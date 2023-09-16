import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/04.research/research_req/view/interview_request_screen.dart';
import 'package:intermission_project/04.research/research_req/view/survey_request_screen.dart';
import 'package:intermission_project/04.research/research_req/view/tester_request_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(title: '리서치 의뢰',),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Text(
                  "누구나 쉽게 리서치를 의뢰하실 수 있습니다!\n논문 리서치도 가능해요!😊\n",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
              ),
              _buildCardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InterviewReqScreen()),
                  );
                },
                buttonName: '인터뷰 의뢰하기',
                description: '인터뷰 매칭비용 할인 중!\n인터뷰 질문개발, 인터뷰이 모집, 진행대행',
              ),
              _buildCardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SurveyReqScreen()),
                  );
                },
                buttonName: '설문 의뢰하기',
                description: '합리적인가격!\n설문 설계-입력-응답 결과 보고까지 한번에!',
              ),
              _buildCardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TesterReqScreen()),
                  );
                },
                buttonName: '제품/서비스 테스터 의뢰하기',
                description: '제품/서비스가 나온 후에도 리서치는 필수!\n테스터를 통해 이용에 불편함이 없는지 알아봐요',
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardButton({
    required VoidCallback onPressed,
    required String buttonName,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomLoginNextButton(
              onPressed: onPressed,
              buttonName: buttonName,
              isButtonEnabled: true,
            ),
            SizedBox(height: 6.0),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
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



class CustomLoginNextButton extends StatefulWidget {
  final String buttonName;
  final bool isButtonEnabled;
  final VoidCallback? onPressed;

  const CustomLoginNextButton({
    required this.onPressed,
    required this.buttonName,
    required this.isButtonEnabled,
    super.key,
  });

  @override
  State<CustomLoginNextButton> createState() => _CustomLoginNextButtonState();
}

class _CustomLoginNextButtonState extends State<CustomLoginNextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 70,
            child: ElevatedButton(
              onPressed: widget.isButtonEnabled ? widget.onPressed : null,
              style: ElevatedButton.styleFrom(
                primary:
                widget.isButtonEnabled ? PRIMARY_COLOR : Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.buttonName,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
