import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/alarm_model.dart';
import 'package:intermission_project/01.user/user/model/point_change_model.dart';
import 'package:intermission_project/01.user/user/model/point_change_response.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/pagination_params.dart';
import 'package:intermission_project/common/repository/base_pagination_repository.dart';
import 'package:retrofit/retrofit.dart';

part 'alarm_repository.g.dart';

final alarmRepositoryProvider = Provider<AlarmRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return AlarmRepository(dio, baseUrl: 'https://$ip/api/notification');
  },
);

// http://$ip/user/me
@RestApi()
abstract class AlarmRepository {
  factory AlarmRepository(Dio dio, {String baseUrl}) = _AlarmRepository;

  // @DELETE('/delete')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<void> deleteUser();

  @POST('/test')
  @Headers({
    'accessToken': 'true',
  })
  Future<PointChangeResponse> testAlarm({
    @Body() required AlarmModel alarmModel,
  });
  // Future <PointChangeResponse> testAlarm(@Body() required AlarmModel alarmModel);
}