import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/model/test_user_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/repository/auth_repository.dart';
import 'package:intermission_project/01.user/user/repository/user_me_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';
import 'package:provider/provider.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  final dio = ref.watch(dioProvider);

  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
    dio: dio,
  );
});

//로그아웃 되었다면 null들어가게끔 UserModelBase?
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final Dio dio;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
    required this.dio,
  }) : super(UserModelLoading()) {
    //유저 정보 바로 가져 오기
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      state = null; //토큰이 2중 1개라도 없다면 로그아웃
      return;
    }

    try {
      final resp = await repository.getMe();
      state = resp; //상태에 바로 GET 한 유저모델저장
    } catch (e, stack) {
      print(e);
      print(stack);

      state = null;
    }
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      print(resp.refreshToken);
      print('logining');

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      //ID잘못이다, PW잘못이다 세부작업 필요
      state = UserModelError(message: '로그인에 실패했습니다');

      return Future.value(state);
    }
  }

  Future<UserModelBase> postUser(SignupUserModel userModel) async {
    try {
      state = UserModelLoading();

      final userResp = await repository.postUser(userModel);
      print(userModel.petYn);

      print("222");
      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '회원가입에 실패했습니다');
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;
    //2가지 동시 실행
    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
