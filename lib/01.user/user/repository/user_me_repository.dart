import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/password_change_model.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/model/test_user_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'https://$ip/api/user/');
  },
);

// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  @POST('/save')
  @Headers({
    'Content-Type': 'application/json;charset=utf-8',
  })
  Future<SignupResponse> postUser(@Body() SignupUserModel user);

  @PATCH('/password')
  @Headers({
    'accessToken': 'true',
  })
  Future<PasswordChangeModel> changePassword({
    @Body() required PasswordChangeModel passwordChangeModel,
  });

  @POST('block/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<InterviewTesterResponse> block({@Path() required int id});
}
///회원가입 RESP
class SignupResponse {
  final int code;
  final String message;

  SignupResponse({required this.code, required this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      code: json['code'],
      message: json['message'],
    );
  }
}

