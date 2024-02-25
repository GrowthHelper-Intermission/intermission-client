
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/alarm/alarm_model.dart';
import 'package:intermission_project/alarm/alarm_repository.dart';

final alarmStateNotifierProvider = StateNotifierProvider<AlarmStateNotifier, AlarmModel?>((ref) {
  return AlarmStateNotifier(repository: ref.watch(alarmRepositoryProvider));
});

// StateNotifier 정의
class AlarmStateNotifier extends StateNotifier<AlarmModel?> {
  final AlarmRepository repository;

  AlarmStateNotifier({
    required this.repository,
  }) : super(null);  // 초기 상태로 null 지정



  // Future<AlarmModel> testAlarm(AlarmModel alarmModel) async {
  //   try {
  //     final testAlarmResp = await repository.testAlarm(alarmModel: alarmModel);
  //     state = testAlarmResp as AlarmModel?;  // 상태 업데이트
  //     print('알람 게시 성공');
  //     return testAlarmResp;
  //   } catch (e) {
  //     print('error reason: ${e}');
  //     throw e;  // 오류를 다시 던집니다.
  //   }
  // }
}