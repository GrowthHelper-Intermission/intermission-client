import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    //내 정보 가져오기

    //유저 정보 바로 가져 오기
    getMe();
  }

  void updateUser({
    String? id,
    String? userTpCd,
    String? userNm,
    String? userId,
    String? pwd,
    String? joinDay,
    String? bankAccount,
    String? accountNumber,
    String? birthDay,
    String? genderCd,
    String? hpNum,
    String? email,
    String? emailVerfYn,
    String? jobCd,
    String? ofcNm,
    String? jobGrdNm,
    String? asignJobCd,
    String? ceoYn,
    String? wedTpCd,
    String? housTpCd,
    String? petYn,
    String? petTpCd,
    String? petNm,
    String? area,
    String? interviewPossibleArea,
    String? occpSidoCd,
    String? occpSigunguCd,
    String? intvSidoCd,
    String? intvSigunguCd,
    String? oflIntvRwdTpCd,
    String? onlIntvRwdTpCd,
    String? mainUseOnlSvcCn,
    String? hobySubs,
    String? rcmdUserCd,
    String? isAgreeYn,
    String? isAgreeDt,
    String? empYn,
    String? empNo,
    String? delYn,
    String? frstRegtDt,
    String? finlUpdtDt,
  }) {
    if (state is UserModel) {
      final userModel = state as UserModel;
      state = userModel.copyWith(
        id: id,
        userTpCd: userTpCd,
        userNm: userNm,
        userId: userId,
        pwd: pwd,
        joinDay: joinDay,
        bankAccount: bankAccount,
        accountNumber: accountNumber,
        birthDay: birthDay,
        genderCd: genderCd,
        hpNum: hpNum,
        email: email,
        emailVerfYn: emailVerfYn,
        jobCd: jobCd,
        ofcNm: ofcNm,
        jobGrdNm: jobGrdNm,
        asignJobCd: asignJobCd,
        ceoYn: ceoYn,
        wedTpCd: wedTpCd,
        housTpCd: housTpCd,
        petYn: petYn,
        petTpCd: petTpCd,
        petNm: petNm,
        area: area,
        interviewPossibleArea: interviewPossibleArea,
        occpSidoCd: occpSidoCd,
        occpSigunguCd: occpSigunguCd,
        intvSidoCd: intvSidoCd,
        intvSigunguCd: intvSigunguCd,
        oflIntvRwdTpCd: oflIntvRwdTpCd,
        onlIntvRwdTpCd: onlIntvRwdTpCd,
        mainUseOnlSvcCn: mainUseOnlSvcCn,
        hobySubs: hobySubs,
        rcmdUserCd: rcmdUserCd,
        isAgreeYn: isAgreeYn,
        isAgreeDt: isAgreeDt,
        empYn: empYn,
        empNo: empNo,
        delYn: delYn,
        frstRegtDt: frstRegtDt,
        finlUpdtDt: finlUpdtDt,
      );
    }
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
      state = resp;
    }catch(e,stack){
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

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      //ID잘못이다, PW잘못이다 세부작업 필요
      state = UserModelError(message: '로그인에 실패했습니다');

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

  // Future<void> register({
  //   required UserModel newUser,
  // }) async {
  //   try {
  //     state = UserModelLoading();
  //
  //     final resp = await repository.postUser(newUser);
  //
  //     await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
  //     await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
  //
  //     state = resp;
  //
  //     return resp;
  //   } catch (e) {
  //     //등록에 실패하면 세부 작업이 필요합니다.
  //     state = UserModelError(message: '회원가입에 실패했습니다');
  //
  //     return Future.value(state);
  //   }
  // }


}
