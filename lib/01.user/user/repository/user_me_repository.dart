import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/change_bank_model.dart';
import 'package:intermission_project/01.user/user/model/delete_user_model.dart';
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

import '../../../common/model/post_response.dart';

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

  @DELETE('/notification/token')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> deleteToken();

  @DELETE('/delete')
  @Headers({
    'accessToken': 'true',
  })
  Future<ScrapResponse> deleteUser(@Body() DeleteUserModel deleteUserModel);

  @PATCH('/bank')
  @Headers({
    'accessToken': 'true',
  })
  Future <void> changeBank(@Body() ChangeBankModel changeBankModel);

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  /// 회원 가입 하기
  @POST('/save')
  @Headers({
    'Content-Type': 'application/json;charset=utf-8',
  })
  Future<SignupResponse> postUser(@Body() SignupUserModel user);

  /// 비밀 번호 변경 하기
  @PATCH('/password')
  @Headers({
    'accessToken': 'true',
  })
  Future<SignupResponse> changePassword({
    @Body() required PasswordChangeModel passwordChangeModel,
  });

  /// 게시글, 유저 차단 하기
  @POST('block/{userId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<PostResponse> block({@Path('userId') required String userId});
}
///회원 가입 Response
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

  factory SignupResponse.toJson(Map<String, dynamic> json) {
    return SignupResponse(
      code: json['code'],
      message: json['message'],
    );
  }
}

