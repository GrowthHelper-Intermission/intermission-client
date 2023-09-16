import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/tester_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/survey_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/tester_req_provider.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

class TesterReqScreen extends ConsumerWidget {
  // static String get routeName => 'request';
  const TesterReqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: 'FGI 등록',
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              TesterReqModel testerReqModel = TesterReqModel(
                taskTpCd: '대표자',
                completeUrl: 'https://docs.google.com/forms/d/e/1FAIpQLScLq4BPS21q1CmeQipv068UyMCYsz9Kxa_3d-8ISF_jlfgByA/viewform',
                exceptCountTime: '30문항 20분이야 씨발!',
                compNm: '그로스헬퍼',
                preferredTime: '1시간 5명 FGI 같은 날 2회 연속',
                researchMethTpCd: '오프라인',
                isAgree: 'Y',
                researchEntryCnt: '5',
              );
              try {
                ref
                    .read(testerReqStateNotifierProvider.notifier)
                    .postTester(testerReqModel);
                print('Research posted successfully');

                // Show the confirmation dialog
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("알림"),
                      content: Text("등록되었습니다!"),
                      actions: [
                        TextButton(
                          child: Text("확인"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            context.goNamed(RootTab
                                .routeName); // Navigate to the next screen
                            ref
                                .read(researchProvider.notifier)
                                .paginate(forceRefetch: true);
                            ref.read(interviewProvider.notifier).paginate();
                            ref.read(surveyProvider.notifier).paginate();
                            ref.read(testerProvider.notifier).paginate();
                          },
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                print(e);
                print('Error occurred while posting research');
              }
            },
            child: Text('FGI 의뢰'),
          ),
        ],
      ),
    );
  }
}
