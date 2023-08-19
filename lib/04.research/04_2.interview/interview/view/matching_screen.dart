import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리서치 의뢰", style: customTextStyle),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: (){
              final url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLScpInA5ldhmSqRSZjw8By71xaZkYoq2thsUlM4eXhEV9ELrMA/viewform');
              // launchUrl(url);
              //외부 폼 이동시
              launchUrl(url,mode: LaunchMode.externalApplication);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(170, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            child: Text(
              '인터뷰 의뢰하기',
            ),
          ),
          ElevatedButton(
            onPressed: (){
              final url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSc6k65N6yNbnTBNN4oHg6A0e_2hrucjMSfkEl3jdTANGKhUJQ/viewform');
              launchUrl(url);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(170, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            child: Text(
              '설문 의뢰하기',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(170, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            child: Text(
              '테스터 의뢰하기',
            ),
          ),
        ],
      ),
    );
  }
}
