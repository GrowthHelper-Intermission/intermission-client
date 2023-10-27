import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/report_req_model.dart';
import 'package:intermission_project/01.user/user/repository/report_req_repository.dart';

// Provider 정의
final reportReqStateNotifierProvider = StateNotifierProvider<ReportReqStateNotifier, ReportReqModel?>((ref) {
  return ReportReqStateNotifier(repository: ref.watch(reportReqRepositoryProvider));
});

// StateNotifier 정의
class ReportReqStateNotifier extends StateNotifier<ReportReqModel?> {
  final ReportReqRepository repository;

  ReportReqStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정

  Future<ReportReqModel> postReport(ReportReqModel reportReqModel) async {
    try {
      final reportResp = await repository.postReport(reportReqModel: reportReqModel);
      state = reportResp;  // 상태 업데이트
      print('게시 성공');
      return reportResp;
    } catch (e) {
      print('error reason: ${e}');
      throw e;  // 오류를 다시 던집니다.
    }
  }
}
