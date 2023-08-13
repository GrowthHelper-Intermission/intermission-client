import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_form_field.dart';

class InterviewDetailTestScreen extends StatelessWidget {

  const InterviewDetailTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '설문조사',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text('뇌졸중 환자 및 보호자 설문 모집'),
                  Text('온라인, 서울 관악구 기준 30분 거리면 오프라인 방문 가능'),
                  Row(
                    children: [
                      Text('비대면/대면  '),
                      Text('1시간 2만원'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('김철수 |'),
                      Text('한국대학병원'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('예상 소요시간'),
                      Text('1시간'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('마감일'),
                      Text('07/10(월) 11:59'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('최소 참여 요건'),
                      Text('20대/10대/30대/40대'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('설명'),
                  Text(
                    '안녕하세요. 한국대학병원 서비스 조사팀 김철수입니다.\n'
                        '현재 한국대학에서는 뇌졸중 환자 및 보호자 설문 모집하고 있습니다.\n\n'
                    '본 설문조사는 \'뇌졸중 연구 논문\'에 참고 자료로 사용될 예정입니다.\n'
                        '작성해주신 모든 응답과 신상 정보는 철저히 보호될 것을 약속드립니다.\n'
                        '감사합니다.',
                    style: TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                  ),
                ],
              ),
            ),
            Text('댓글 2개'),
            CustomTextFormField(
              controller: commentController,
              hintText: '댓글을 입력해 주세요',
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}
