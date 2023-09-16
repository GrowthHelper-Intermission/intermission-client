import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/interview_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
import 'package:intermission_project/04.research/research_req/provider/survey_req_provider.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';
import 'package:intermission_project/common/view/root_tab.dart';

class SurveyReqScreen extends ConsumerWidget {
  // static String get routeName => 'request';
  const SurveyReqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '설문 등록',
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              SurveyReqModel surveyReqModel = SurveyReqModel(
                taskTpCd: '대표자',
                completeUrl: 'https://docs.google.com/forms/d/e/1FAIpQLScLq4BPS21q1CmeQipv068UyMCYsz9Kxa_3d-8ISF_jlfgByA/viewform',
                exceptCountTime: '30문항 20분이야 씨발!',
                researchEntryCnt: '5',
                screening: '스크리닝 조건 존나 빡셀거야',
                surveyDev: 'Y',
                surveyRes: 'Y',
                isAgree: 'Y',
              );
              try {
                ref
                    .read(surveyReqStateNotifierProvider.notifier)
                    .postSurvey(surveyReqModel);
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
            child: Text('설문 의뢰'),
          ),
        ],
      ),
    );
  }
}
