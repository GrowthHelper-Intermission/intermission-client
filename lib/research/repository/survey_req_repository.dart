import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/research/model/survey_req_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intermission_project/common/model/common_response.dart';

part 'survey_req_repository.g.dart';

final surveyReqRepositoryProvider = Provider<SurveyReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return SurveyReqRepository(dio,
        baseUrl: '$ip/api');
  },
);

@RestApi()
abstract class SurveyReqRepository {
  factory SurveyReqRepository(Dio dio, {String baseUrl}) =
  _SurveyReqRepository;

  @POST('/survey')
  @Headers({
    'accessToken': 'true',
  })
  Future<CommonResponse> postSurvey({
    @Body() required SurveyReqModel surveyReqModel,
  });
}




