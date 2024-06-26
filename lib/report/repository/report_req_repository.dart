import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/report/model/report_req_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_req_repository.g.dart';

final reportReqRepositoryProvider = Provider<ReportReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return ReportReqRepository(dio,
        baseUrl: '$ip/api/ask');
  },
);

@RestApi()
abstract class ReportReqRepository {
  factory ReportReqRepository(Dio dio, {String baseUrl}) =
  _ReportReqRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<ReportReqModel> postReport({
    @Body() required ReportReqModel reportReqModel,
  });
}