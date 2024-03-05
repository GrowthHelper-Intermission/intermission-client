import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/model/common_response.dart';
import 'package:intermission_project/research/model/tester_req_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tester_req_repository.g.dart';

final testerReqRepositoryProvider = Provider<TesterReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return TesterReqRepository(dio,
        baseUrl: '$ip/api/tester');
  },
);

@RestApi()
abstract class TesterReqRepository {
  factory TesterReqRepository(Dio dio, {String baseUrl}) =
  _TesterReqRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommonResponse> postTester({
    @Body() required TesterReqModel testerReqModel,
  });
}



