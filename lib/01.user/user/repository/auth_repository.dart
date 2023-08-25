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

  // return AuthRepository(baseUrl: 'http://localhost:8080/api/auth', dio: dio);
  // 34.64.77.5/api/auth/login
  return AuthRepository(baseUrl: 'http://34.64.77.5:8080/api/auth', dio: dio);
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
    print('seiral');
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
      '$baseUrl/token',
      options: Options(headers: {'refreshToken': 'true'}),
    );
    print(resp.data);
    print('Hello');
    return TokenResponse.fromJson(resp.data);
  }

}