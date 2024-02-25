import 'package:intermission_project/04.research/research_req/model/interview_req_model.dart';
import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/04.research/research_req/repository/research_req_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_req_repository.g.dart';

final interviewReqRepositoryProvider = Provider<InterviewReqRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return InterviewReqRepository(dio,
        baseUrl: '$ip/api/interview');
  },
);

@RestApi()
abstract class InterviewReqRepository {
  factory InterviewReqRepository(Dio dio, {String baseUrl}) =
  _InterviewReqRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<ApiResponse> postInterview({
    @Body() required InterviewReqModel interviewReqModel,
  });
}