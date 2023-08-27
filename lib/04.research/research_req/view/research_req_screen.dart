import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/04.research/research/view/research_screen.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/provider/research_req_provider.dart';
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
                mainTitle: '인터미션 사전 조사',
                subTitle: '오프라인, 서울 관악구 기준 30분 거리면 오프 라인 방문 가능',
                dueDate: '2023-09-05',
                exceptTime: '2',
                minAge: '20대 / 10대 / 30대 / 40대',
                detail: '안녕하세요. 한국대학병원 서비스 조사팀 김철수입니다. 현재 한국대학에서는 뇌졸중 환자 및 보호자 설문 모집하고 있습니다. 본 설문조사는 뇌졸중 연구 논문에 참고 자료로 사용될 예정입니다. 작성해주신 모든 응답과 신상 정보는 철저히 보호될 것을 약속드립니다. 감사합니다.',
                researchType: "test",
                researchMethTpCd: '온라인',
                researchRewdAmt: "30000원",
                userId: "12",
                email: "chaseB",
                taskTpCd: "PM업무",
                etcTaskSubs: "기타직",
                compNm: "카카오",
                researchTgtZendTpCd: "M",
                researchEntryCnt: "4",
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
              context.goNamed(ResearchScreen.routeName);
            },
            child: Text('리서치 등록'),
          ),
        ],
      ),
    );
  }
}
