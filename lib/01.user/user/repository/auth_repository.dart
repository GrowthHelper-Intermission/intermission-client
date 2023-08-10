import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/login_response.dart';
import 'package:intermission_project/common/model/token_response.dart';
import 'package:intermission_project/common/utils/data_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: 'http://localhost:8080/api', dio: dio);
});

class AuthRepository {
  //baseUrl == http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');
    print(serialized);
    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'Authorization': 'Basic $serialized',
        },
      ),
    );
    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token/refresh',
      options: Options(headers: {'refreshToken': 'true'}),
    );
    print(resp.data);
    print('Hello');
    return TokenResponse.fromJson(resp.data);
  }

  // Future<void> signUp({required String username, required String password}) async {
  //   try {
  //     final resp = await dio.post(
  //       '$baseUrl/signup',
  //       data: {
  //         'username': username,
  //         'password': password,
  //         // 추가적으로 필요한 다른 데이터들을 이곳에 추가
  //       },
  //       // 필요한 경우 헤더나 다른 옵션 추가
  //     );
  //
  //     if (resp.statusCode == 200) {
  //       // 회원가입 성공 처리
  //       print('성공');
  //     } else {
  //       // 회원가입 실패 처리
  //       print('실패');
  //     }
  //   } catch (e) {
  //     // 네트워크 오류나 기타 문제 발생시 처리
  //     print('네트워크 오류');
  //   }
  // }


}