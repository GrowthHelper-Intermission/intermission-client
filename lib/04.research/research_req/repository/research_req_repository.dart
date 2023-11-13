import 'package:intermission_project/04.research/research_req/model/research_req_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers; //주의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'research_req_repository.g.dart';

final researchReqRepositoryProvider = Provider<ResearchReqRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    // return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
    // 'http://localhost:8080/api/user/save'
    return ResearchReqRepository(dio,
        baseUrl: 'http://$ip/api/research');
  },
);

@RestApi()
abstract class ResearchReqRepository {
  factory ResearchReqRepository(Dio dio, {String baseUrl}) =
      _ResearchReqRepository;

  @POST('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<ApiResponse> postResearch({
    @Body() required ResearchReqModel researchReqModel,
  });
}



class ApiResponse {
  final int code;
  final String message;
  final String? data;

  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }
}
