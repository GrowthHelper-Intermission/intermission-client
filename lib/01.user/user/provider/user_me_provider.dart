import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/01.user/user/model/password_change.dart';
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
// final userModelProvider = StateProvider<UserModel?>((ref) => null);

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

  // UserMeStateNotifier 클래스 내부에 추가
  Future<void> changePassword(String checkPassword, String newPassword) async {
    try {
      // 저장된 액세스 토큰을 가져옵니다.
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        // 토큰이 없는 경우 처리...
        print('잘못된 접근입니다.');
        return;
      }

      // 비밀번호 변경 API 호출 로직
      final passwordChangeModel = PasswordChangeModel(
        checkPassword: checkPassword,
        newPassword: newPassword,
      );

      final resp = await repository.changePassword(
          'Bearer $accessToken', // Bearer 토큰 형식을 사용합니다.
          passwordChangeModel
      );

      // 비밀번호 변경에 성공한 경우의 로직...
    } catch (e) {
      // 비밀번호 변경에 실패한 경우의 로직 (예: 에러 메시지 표시 등)
    }
  }


  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    print('accessToken is : $accessToken');

    //refreshToken이 만료된게 아니라면 -> 강제 로그아웃(이대로하면 너무 자주로그아웃됨)
    if (refreshToken == null) {
      state = null; //토큰이 2중 1개라도 없다면 로그아웃
      return;
    }

    final resp = await repository.getMe('Bearer $accessToken');

    // ref.watch(userModelProvider.notifier).state = resp;

    state = resp;

    // try {
    //   final resp = await repository.getMe();
    //   // ref.watch(userModelProvider.notifier).state = resp; //추가
    //   // state = resp; //상태에 바로 GET 한 유저모델저장
    //   print(resp);
    //   print("Hello resp");
    //   if(resp != null) {
    //     ref
    //         .watch(userModelProvider.notifier)
    //         .state = resp; //추가
    //     state = resp;
    //   }
    //   else{
    //     print('getMe에서 에러');
    //   }
    // } catch (e, stack) {
    //   print(e);
    //   print(stack);
    //
    //   state = null;
    // }
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

      // 401 error? -> 아이디나 비번 잘못된거임

      print('login3');
      //응답받은 refresh, accesstoken을 storage에 그대로 넣어준다
      //

      print(resp.refreshToken);
      print(resp.accessToken);

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      print('refreshToken: ${resp.refreshToken}');
      print('accessToken: ${resp.accessToken}');
      print('logining');

      //storage에 넣은 토큰이 유효한지 판단하기 위해서(서버에서 내 유저정보를 가져올 수 있다면?) getMe()
      // 유효한 토큰임을 인증
      final userResp = await repository.getMe('Bearer ${resp.accessToken}');

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

  Future<UserModel> postUser(SignupUserModel signupUserModel) async {
    try {
      state = UserModelLoading();

      // 1. 회원가입 POST
      final userResp = await repository.postUser(signupUserModel);
      print(userResp.birthDay);

      // 딜레이 추가: 2초 동안 대기
      await Future.delayed(Duration(seconds: 2));

      // 2. 회원가입 완료라 가정, 로그인
      final loginResp = await login(
        username: signupUserModel.email!,
        password: signupUserModel.pwd!,
      );

      // 딜레이 추가: 2초 동안 대기
      await Future.delayed(Duration(seconds: 2));

      // 3. 딜레이 후 getMe() 호출하거나 다른 로직 수행
      // 이렇게 하면 딜레이 후에 getMe()가 호출되어 사용자 정보를 가져옵니다.
      getMe();

      // 4. 최종 결과 반환
      return loginResp as UserModel;

    } catch (e) {
      print('Hallo');
      state = UserModelError(message: '회원가입에 실패했습니다');
      return Future.error(UserModelError(message: '회원가입에 실패했습니다'));
    }
  }


  Future<void> logout() async {
    state = null;
    //2가지 동시 실행

    print('ajw');
    print(storage.read(key: REFRESH_TOKEN_KEY));
    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
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
