import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/common_response.dart';
import 'package:intermission_project/research/model/survey_req_model.dart';
import 'package:intermission_project/research/repository/survey_req_repository.dart';

// Provider 정의
final surveyReqStateNotifierProvider = StateNotifierProvider<SurveyReqStateNotifier, CommonResponse?>((ref) {
  return SurveyReqStateNotifier(repository: ref.watch(surveyReqRepositoryProvider));
});

// StateNotifier 정의
class SurveyReqStateNotifier extends StateNotifier<CommonResponse?> {
  final SurveyReqRepository repository;

  SurveyReqStateNotifier({
    required this.repository,
  }) : super(null);

  Future<CommonResponse> postSurvey(SurveyReqModel surveyReqModel) async {
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




