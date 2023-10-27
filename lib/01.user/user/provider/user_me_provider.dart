import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intermission_project/01.user/point/model/point_model.dart';
import 'package:intermission_project/01.user/user/model/password_change_model.dart';
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/model/test_user_model.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/repository/auth_repository.dart';
import 'package:intermission_project/01.user/user/repository/user_me_repository.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/storage/secure_storage.dart';

final userMeProvider =
StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
    ref: ref, //getMe로 받은걸 뿌려주기 위함
  );
});

//로그아웃 되었다면 null들어가게끔 UserModelBase?
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final Ref ref; // ProviderReference 인스턴스

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
    required this.ref,
  }) : super(UserModelLoading()) {
    //유저 정보 바로 가져 오기
    // logout();
    getMe();
  }

  // UserMeStateNotifier 클래스 내부에 추가
  Future<void> changePassword(PasswordChangeModel passwordChangeModel) async {
    try {
      // 저장된 액세스 토큰을 가져옵니다.
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);


      if (accessToken == null) {
        print('잘못된 접근입니다.');
        return;
      }

      final changeResp = await repository.changePassword(passwordChangeModel: passwordChangeModel);

      print(passwordChangeModel.checkPassword);

      getMe();
    } catch (e) {
      // 비밀번호 변경에 실패한 경우의 로직 (예: 에러 메시지 표시 등)
    }
  }


  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    print('바로밑이 refresh');
    print(refreshToken);
    print(accessToken);

    //refreshToken이 만료된게 아니라면 -> 강제 로그아웃(이대로하면 너무 자주로그아웃됨)
    if (refreshToken == null || accessToken == null) {
      state = null; //토큰이 2중 1개라도 없다면 로그아웃
      return;
    }

    final resp = await repository.getMe();
    state = resp;
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

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      //응답받은 refresh, accesstoken을 storage에 그대로 넣어준다

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      //storage에 넣은 토큰이 유효한지 판단하기 위해서(서버에서 내 유저정보를 가져올 수 있다면?) getMe()
      // 유효한 토큰임을 인증
      final userResp = await repository.
      getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      //ID잘못이다, PW잘못이다 세부작업 필요 ->  Repository 수정필요
      state = UserModelError(message: '로그인에 실패했습니다');

      return Future.value(state);
    }
  }

  Future<SignupResponse> postUser(SignupUserModel signupUserModel) async {
    try {
      state = UserModelLoading();

      // 1. 회원가입 POST
      final userResp = await repository.postUser(signupUserModel);

      // 응답 출력
      print('Server Response: $userResp');

      // 딜레이 추가: 2초 동안 대기
      await Future.delayed(Duration(seconds: 2));

      // getMe();

      // 4. 최종 결과 반환
      return SignupResponse.fromJson(userResp as Map<String, dynamic>); // 이 부분 추가

    } catch (e) {
      print('Hallo');
      state = UserModelError(message: '회원가입에 실패했습니다');
      return Future.error(UserModelError(message: '회원가입에 실패했습니다'));
    }
  }

  Future<InterviewTesterResponse> postBlock(int id) async{
    try{
      final blockResp = await repository.block(id: id);
      // // 딜레이 추가: 2초 동안 대기
      // await Future.delayed(Duration(seconds: 2));
      return blockResp;
    }catch(e){
      state = UserModelError(message: '차단에 실패했습니다');
      return Future.error(UserModelError(message: '차단에 실패했습니다'));
    }
  }


  Future<void> logout() async {
    state = null;
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}




