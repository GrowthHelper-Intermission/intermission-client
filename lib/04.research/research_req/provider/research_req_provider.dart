import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/repository/research_req_repository.dart';

// Provider 정의
final researchReqStateNotifierProvider = StateNotifierProvider<ResearchReqStateNotifier, ApiResponse?>((ref) {
  return ResearchReqStateNotifier(repository: ref.watch(researchReqRepositoryProvider));
});

// StateNotifier 정의
class ResearchReqStateNotifier extends StateNotifier<ApiResponse?> {
  final ResearchReqRepository repository;

  ResearchReqStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정

  Future<ApiResponse> postResearch(ResearchReqModel researchReqModel) async {
    try {
      final researchResp = await repository.postResearch(researchReqModel: researchReqModel);
      state = researchResp;  // 상태 업데이트
      print('게시 성공');
      return researchResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}

