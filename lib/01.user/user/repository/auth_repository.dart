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
      ref: ref, baseUrl: 'https://$ip/api/auth', dio: dio); // Pass `ref` here
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

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final firebaseToken = await readTokenFromSecureStorage();

    print('here firebaseToken!: ');
    print(firebaseToken);

    final resp = await dio.post(
      '$baseUrl/login',
      data: {
        "firebaseToken": firebaseToken.toString(),
      },
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );
    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
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
