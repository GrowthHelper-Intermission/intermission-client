// Provider 정의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/noti_req_model.dart';
import 'package:intermission_project/04.research/research/repository/noti_req_repository.dart';

final notiReqStateNotifierProvider = StateNotifierProvider<NotiReqStateNotifier, NotiReqModel?>((ref) {
  return NotiReqStateNotifier(repository: ref.watch(notiReqRepositoryProvider));
});

// StateNotifier 정의
class NotiReqStateNotifier extends StateNotifier<NotiReqModel?> {
  final NotiReqRepository repository;

  NotiReqStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정

  Future<NotiReqModel> postReport(NotiReqModel notiReqModel) async {
    try {
      final notiResp = await repository.postReport(notiReqModel: notiReqModel);
      state = notiResp;  // 상태 업데이트
      print('공지 게시 성공');
      return notiResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}
