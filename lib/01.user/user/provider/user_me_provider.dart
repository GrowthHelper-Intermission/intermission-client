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

// Provider-in-Provider
final userModelProvider = StateProvider<UserModel?>((ref) => null);

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
    ref: ref, //getMe로 받은걸 뿌려주기 위함
  );
});

//로그아웃 되었다면 null들어가게끔 UserModelBase?
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final Dio dio;
  final Ref ref; // ProviderReference 인스턴스

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
    required this.dio,
    required this.ref,
  }) : super(UserModelLoading()) {
    //유저 정보 바로 가져 오기
    print(13);
    getMe();
    print(15);
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
      // ref.watch(userModelProvider.notifier).state = resp; //추가
      // state = resp; //상태에 바로 GET 한 유저모델저장
      print(resp);
      print("Hello resp");
      if(resp != null) {
        ref
            .watch(userModelProvider.notifier)
            .state = resp; //추가
        state = resp;
      }
      else{
        print('getMe에서 에러');
      }
    } catch (e, stack) {
      print(e);
      print(stack);

      state = null;
    }
  }

  //UserModeBase를 반환타입으로 한 이유는 3가지 경우때문
  //1. 정상 로그인
  //2. 로그인이 안될수도 있음
  //3. 로딩중
  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();
      print('login1');
      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      print('login3');
      //응답받은 refresh, accesstoken을 storage에 그대로 넣어준다
      //

      print(resp.refreshToken);
      print(resp.accessToken);

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      print(resp.refreshToken);
      print('logining');

      //storage에 넣은 토큰이 유효한지 판단하기 위해서(서버에서 내 유저정보를 가져올 수 있다면?) getMe()
      // 유효한 토큰임을 인증
      final userResp = await repository.getMe();

      // ref.watch(userModelProvider.notifier).state = userResp; //추가
      ref.watch(userMeProvider.notifier).state = userResp;
      state = userResp;

      return userResp;
    } catch (e) {
      //ID잘못이다, PW잘못이다 세부작업 필요 ->  Repository 수정필요
      state = UserModelError(message: '로그인에 실갸패했습니다');

      return Future.value(state);
    }
  }

  // Future<UserModelBase> postUser(SignupUserModel signupUserModel) async {
  //   try {
  //     state = UserModelLoading();
  //
  //     //1. 회원가입 POST
  //     final userResp = await repository.postUser(signupUserModel);
  //
  //     print(userResp.birthDay);
  //
  //     //2. 회원가입 완료라 가정, 로그인
  //     final loginResp = await login(
  //       username: signupUserModel.email!,
  //       password: signupUserModel.pwd!,
  //     );
  //
  //     //3. login 과정에서 state = getMe() 즉 UserModel로 변경
  //     state = loginResp;
  //
  //     return loginResp;
  //
  //
  //   } catch (e) {
  //     print('Hallo');
  //     state = UserModelError(message: '회원가입에 실패했습니다');
  //     return Future.value(state);
  //   }
  // }

  Future<UserModel> postUser(SignupUserModel signupUserModel) async {
    try {
      state = UserModelLoading();

      //1. 회원가입 POST
      final userResp = await repository.postUser(signupUserModel);

      print(userResp.birthDay);

      //2. 회원가입 완료라 가정, 로그인
      final loginResp = await login(
        username: signupUserModel.email!,
        password: signupUserModel.pwd!,
      );

      //3. login 과정에서 state = getMe() 즉 UserModel로 변경
      state = loginResp;

      return loginResp as UserModel; // 타입을 UserModel로 캐스팅


    } catch (e) {
      print('Hallo');
      state = UserModelError(message: '회원가입에 실패했습니다');
      return Future.error(UserModelError(message: '회원가입에 실패했습니다')); //Future.error를 사용하여 에러 반환
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