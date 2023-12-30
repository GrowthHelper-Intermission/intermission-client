import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intermission_project/common/const/data.dart';
import 'package:intermission_project/common/dio/dio.dart';
import 'package:intermission_project/common/model/login_response.dart';
import 'package:intermission_project/common/model/token_response.dart';
import 'package:intermission_project/common/utils/data_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../provider/firebase_token_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(
      ref: ref, baseUrl: 'https://$ip/api', dio: dio); // Pass `ref` here
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;
  final ProviderRef ref;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
    required this.ref,
  });

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');
    final firebaseToken = await readTokenFromSecureStorage();

    final resp = await dio.post(
      '$baseUrl/auth/login',
      data: {
        "firebaseToken": firebaseToken.toString(),
      },
      options: Options(
        headers: {
          /// 아이디 비번
          'authorization': 'Basic $serialized',
        },
      ),
    );
    // return LoginResponse.fromJson(resp.data);
    // 응답 헤더에서 AccessToken과 RefreshToken 추출
    final accessToken = resp.headers.value('Authorization');
    final refreshToken = resp.headers.value('Authorization-refresh');

    // 토큰을 Secure Storage에 저장
    const storage = FlutterSecureStorage();
    if (accessToken != null) {
      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
    }
    if (refreshToken != null) {
      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
    }
  }

  Future<void> logout() async {
    final refreshToken = await FlutterSecureStorage().read(key: REFRESH_TOKEN_KEY);
    final accessToken = await FlutterSecureStorage().read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.post(
      '$baseUrl/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Authorization-refresh': 'Bearer $refreshToken',
        },
      ),
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/auth/token',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );
    return TokenResponse.fromJson(
      resp.data,
    );
  }

  Future<void> getEmail(String email) async {
    final resp = await dio.post(
      'https://$ip/api/auth',
      data: {
        "email": email.toString().toString()
      }
    );
  }
}

Future<String?> readTokenFromSecureStorage() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'firebase_token');
}
