import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
import 'package:intermission_project/04.research/research_req/repository/interview_req_repository.dart';
import 'package:intermission_project/04.research/research_req/repository/research_req_repository.dart';
import 'package:intermission_project/04.research/research_req/repository/survey_req_repository.dart';

// Provider 정의
final surveyReqStateNotifierProvider = StateNotifierProvider<SurveyReqStateNotifier, ApiResponse?>((ref) {
  return SurveyReqStateNotifier(repository: ref.watch(surveyReqRepositoryProvider));
});

// StateNotifier 정의
class SurveyReqStateNotifier extends StateNotifier<ApiResponse?> {
  final SurveyReqRepository repository;

  SurveyReqStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정

  Future<ApiResponse> postSurvey(SurveyReqModel surveyReqModel) async {
    try {
      final researchResp = await repository.postSurvey(surveyReqModel: surveyReqModel);
      state = researchResp;  // 상태 업데이트
      print('게시 성공');
      return researchResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}




