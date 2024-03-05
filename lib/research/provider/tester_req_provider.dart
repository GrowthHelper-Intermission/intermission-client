import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/common_response.dart';
import 'package:intermission_project/research/model/tester_req_model.dart';
import 'package:intermission_project/research/repository/tester_req_repository.dart';

// Provider 정의
final testerReqStateNotifierProvider = StateNotifierProvider<TesterReqStateNotifier, CommonResponse?>((ref) {
  return TesterReqStateNotifier(repository: ref.watch(testerReqRepositoryProvider));
});

// StateNotifier 정의
class TesterReqStateNotifier extends StateNotifier<CommonResponse?> {
  final TesterReqRepository repository;

  TesterReqStateNotifier({
    required this.repository,
  }) : super(null);

  Future<CommonResponse> postTester(TesterReqModel testerReqModel) async {
    try {
      final researchResp = await repository.postTester(testerReqModel: testerReqModel);
      state = researchResp;  // 상태 업데이트
      print('게시 성공');
      return researchResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}




