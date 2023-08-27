import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/01.user/user/model/password_change_model.dart';
import 'package:intermission_project/01.user/user/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/model/test_user_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'http://34.64.77.5:8080/api/user');
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

  // @GET('/point')
  // @Headers({
  //   'accessToken': 'true',
  // })
  // Future<PointModel> getPoint();

  @POST('/save')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> postUser(@Body() SignupUserModel user);

  @PATCH('/password')
  @Headers({
    'accessToken': 'true',
  })
  Future<PasswordChangeModel> changePassword({
    @Body() required PasswordChangeModel passwordChangeModel,
  });

  // @GET('/basket')
  // @Headers({
  //   'accessToken' : 'true',
  // })
  // Future<List<BasketItemModel>> getBasket();

  // @PATCH('/basket')
  // @Headers({
  //   'accessToken' : 'true',
  // })
  // Future<List<BasketItemModel>> patchBasket({
  //   @Body() required PatchBasketBody body, //pbb가 toJson 실행되면서 body값으로 변경된다음에 api요청들어감
  // });
}
