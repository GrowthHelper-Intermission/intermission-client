import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/common_response.dart';
import 'package:intermission_project/research/model/interview_req_model.dart';
import 'package:intermission_project/research/repository/interview_req_repository.dart';

// Provider 정의
final interviewReqStateNotifierProvider = StateNotifierProvider<InterviewReqStateNotifier, CommonResponse?>((ref) {
  return InterviewReqStateNotifier(repository: ref.watch(interviewReqRepositoryProvider));
});

// StateNotifier 정의
class InterviewReqStateNotifier extends StateNotifier<CommonResponse?> {
  final InterviewReqRepository repository;

  InterviewReqStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정

  Future<CommonResponse> postInterview(InterviewReqModel interviewReqModel) async {
    try {
      final researchResp = await repository.postInterview(interviewReqModel: interviewReqModel);
      state = researchResp;  // 상태 업데이트
      print('게시 성공');
      return researchResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}




