import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/research/model/interview_req_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intermission_project/common/model/common_response.dart';

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
  Future<CommonResponse> postInterview({
    @Body() required InterviewReqModel interviewReqModel,
  });
}