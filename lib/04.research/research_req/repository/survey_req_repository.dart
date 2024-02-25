import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/survey_req_model.dart';
import 'package:intermission_project/04.research/research_req/repository/research_req_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  Future<ApiResponse> postSurvey({
    @Body() required SurveyReqModel surveyReqModel,
  });
}




