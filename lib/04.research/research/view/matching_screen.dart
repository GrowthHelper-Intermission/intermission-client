import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: NormalAppbar(
        title: '리서치 의뢰',
        color: PRIMARY_COLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // add this
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
                  ),
                  height: 90,
                  alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "누구나 쉽게 리서치를 의뢰하실 수 있습니다!\n논문 리서치도 가능해요!\n",
                      textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InterviewReqScreen(),
                    ),
                  );
                },
                title: '인터뷰 의뢰하기',
                description: '인터뷰 매칭비용 할인 중!\n인터뷰 질문개발, 인터뷰이 모집, 진행대행',
                svgAssetPath: 'assets/request/request1.svg',
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurveyReqScreen(),
                    ),
                  );
                },
                title: '설문 의뢰하기',
                description: '합리적인가격!\n설문 설계-입력-응답 결과 보고까지 한번에!',
                svgAssetPath: 'assets/request/request2.svg',
              ),
              _buildClickableContainer(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TesterReqScreen(),
                    ),
                  );
                },
                title: '제품/서비스 테스터 의뢰하기',
                description:
                    '제품/서비스가 나온 후에도 리서치는 필수!\n테스터를 통해 이용에 불편함이 없는지 알아봐요',
                svgAssetPath: 'assets/request/request3.svg',
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

Widget _buildClickableContainer({
  required VoidCallback onTap,
  required String title,
  required String description,
  required String svgAssetPath, // SVG 파일 경로를 위한 새로운 파라미터
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  svgAssetPath,
                  width: 27,
                  height: 27,
                ),
              ),
              SizedBox(width: 15),
              Expanded( // 텍스트가 SVG 옆에 오도록 Expanded로 감싸기
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}



