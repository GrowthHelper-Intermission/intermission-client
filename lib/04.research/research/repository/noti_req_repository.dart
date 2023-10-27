import 'package:intermission_project/01.user/user/model/report_req_model.dart';
import 'package:intermission_project/04.research/research/model/noti_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'noti_req_repository.g.dart';

final notiReqRepositoryProvider = Provider<NotiReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return NotiReqRepository(dio,
        baseUrl: 'http://$ip/api/noti');
  },
);

@RestApi()
abstract class NotiReqRepository {
  factory NotiReqRepository(Dio dio, {String baseUrl}) =
  _NotiReqRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<NotiReqModel> postReport({
    @Body() required NotiReqModel notiReqModel,
  });
}