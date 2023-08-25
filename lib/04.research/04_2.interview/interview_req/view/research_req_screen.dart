import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/04_2.interview/interview/view/interview_screen.dart';
import 'package:intermission_project/04.research/04_2.interview/interview_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/04_2.interview/interview_req/provider/research_req_provider.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:intermission_project/common/view/home_screen.dart';

class ResearchReqScreen extends ConsumerWidget {
  static String get routeName => 'request';
  const ResearchReqScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '리서치 등록',
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              ResearchReqModel newResearch = ResearchReqModel(
                mainTitle: '그로스 헬퍼 사전 조사',
                subTitle: '오프라인, 부산 관악구 기준 30분 거리면 오프 라인 방문 가능',
                dueDate: '2023-09-05',
                exceptTime: '2',
                minAge: 'Y',
                detail: '이러이러한 긴내용입니다.',
                researchType: "interview",
                researchMethTpCd: '온라인',
                researchRewdAmt: "30000원",
                userId: "12",
                email: "chaseB",
                taskTpCd: "PM업무",
                etcTaskSubs: "기타직",
                compNm: "카카오",
                researchTgtZendTpCd: "M",
                researchEntryCnt: "4명",
                etcReqCn: "동대생",
                researchPostAgreeYn: "동의",
                hpNum: "010-1313-2424",
                delYn: "N"
              );
              try{
                ref.read(researchReqStateNotifierProvider.notifier).postResearch(newResearch);
                print('성공적 수행');
              }catch(e){
                print(e);
                print('에러');
              }
              context.goNamed(InterviewScreen.routeName);
            },
            child: Text('리서치 등록'),
          ),
        ],
      ),
    );
  }
}
