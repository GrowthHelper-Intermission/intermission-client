import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/repository/user_me_repository.dart';
import 'package:intermission_project/01.user/user/view/certification_result_provider.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page1.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page2.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/common/const/data.dart';
import 'dart:convert';
import 'package:intermission_project/common/view/splash_screen.dart';

import '../../../common/view/select_screen.dart';

class CertificationResult extends ConsumerWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  final Map<String, String>? result;

  bool _isGetCertificationResultCalled = false;

  /// 1

  CertificationResult({super.key, this.result});

  static String get routeName => 'certification-result';

  Future<String> getAccessToken(String impKey, String impSecret) async {
    var url = Uri.parse('https://api.iamport.kr/users/getToken');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'imp_key': impKey,
        'imp_secret': impSecret,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['response']['access_token'];
    } else {
      throw Exception('Failed to load access token');
    }
  }

  Future<void> getCertificationResult(
      String impUid,
      String accessToken,
      BuildContext context,
      WidgetRef ref,
      FlutterSecureStorage flutterSecureStorage) async {
    var url = Uri.parse('https://api.iamport.kr/certifications/$impUid');
    var response = await http.get(url, headers: {'Authorization': accessToken});

    /// Iamport에서 성공적으로 데이터 받아 왓다면
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      var responseData = json.decode(response.body)['response'];

      // 필요한 데이터 추출
      final birthday = responseData['birthday'].toString();
      final uniqueKey = responseData['unique_key'].toString();
      final certifiedAt = responseData['certified_at'].toString();
      final phoneNumber = responseData['phone'].toString();
      final userName = responseData['name'].toString();

      print('uniqueKey:');
      print(uniqueKey);

      // 상태 변경
      final state = ref.read(signupUserProvider.notifier);
      state.setBirthday(birthday);
      state.setUniqueKey(uniqueKey);
      state.setCertifiedAt(certifiedAt);
      state.setPhoneNumber(phoneNumber);
      state.setUsername(userName);

      final SignupUserModel newUser = SignupUserModel(
        email: state.email,
        password: state.password,
        isTermsAgreed: state.isTermsAgreed,
        isPrivacyAgreed: state.isPrivacyAgreed,
        jobCd: state.jobCd,
        asignJobCd: state.asignJobCd,
        wedCd: state.wedCd,
        genderCd: state.genderCd,
        petCd: state.petCd,
        occpSidoCd: state.occpSidoCd,
        occpSigunguCd: state.occpSigunguCd,
        houseTpCd: state.housTpCd,
        userCd: state.userCd,
        birthday: state.birthday,
        uniqueKey: state.uniqueKey,
        certifiedAt: state.certifiedAt,
        phoneNumber: state.phoneNumber,
        userName: state.userName,
      );
      try {
        var dio = Dio();
        var response = await dio.post(
          'https://$ip/api/user/save',
          data: {
            "birthday": newUser.birthday,
            "email": newUser.email,
            "userName": newUser.userName,
            "password": newUser.password,
            "uniqueKey": "test3",
            "certifiedAt": newUser.certifiedAt,
            "phoneNumber": newUser.phoneNumber,
            "jobCd": newUser.jobCd,
            "asignJobCd": newUser.asignJobCd,
            "wedCd": newUser.wedCd,
            "genderCd": newUser.genderCd,
            "petCd": newUser.petCd,
            "occpSidoCd": newUser.occpSidoCd,
            "occpSigunguCd": newUser.occpSigunguCd,
            "housTpCd": newUser.houseTpCd,
            "userCd": newUser.userCd,
            "isTermsAgreed": newUser.isTermsAgreed,
            "isPrivacyAgreed": newUser.isPrivacyAgreed,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json;charset=utf-8',
            },
          ),
        );
        print('성공적 수행');
        if (response.statusCode == 201) {
          var accessToken = response.headers.value('Authorization');
          var refreshToken = response.headers.value('Authorization-refresh');
          print('accessToken: $accessToken');
          print('refreshToken: $refreshToken');

          await flutterSecureStorage.write(
              key: REFRESH_TOKEN_KEY, value: refreshToken);
          await flutterSecureStorage.write(
              key: ACCESS_TOKEN_KEY, value: accessToken);
          ref.read(userMeProvider.notifier).getMe();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignupScreenPage1()),
          );
        }
      } catch (e) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('알림!'),
              content: Text('중복된 계정입니다!'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupScreenPage2()),
                    );
                  },
                ),
              ],
            );
          },
        );
        print(e);
      }
    }

    /// 아임포트에서 문제가 생겼을때
    else {
      print('아임포트 쪽 에러');
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certificationState = ref.watch(certificationResultProvider);
    FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

    if (result!['success'] == 'true' && !_isGetCertificationResultCalled) {
      _isGetCertificationResultCalled = true;
      getAccessToken('1188833256121578',
              'WqgqCGlYJPB9e5j7bpTsPPMDhZP7mdncthivWfKYDrcDRpXYbCCphRqkEwqfcLXZMJ0TVl2h2E6XXJhk')
          .then((accessToken) => getCertificationResult(result!['imp_uid']!,
              accessToken, context, ref, flutterSecureStorage));
    }
    return SplashScreen(
      message: '이전화면으로 이동중...',
    );
  }
}
