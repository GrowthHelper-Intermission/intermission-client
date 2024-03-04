import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intermission_project/common/const/data.dart';
import 'dart:convert';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:intermission_project/user/user/model/signup_user_model.dart';
import 'package:intermission_project/user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/user/user/provider/user_me_provider.dart';
import 'package:intermission_project/user/user/repository/auth_repository.dart';

import '../common/view/select_screen.dart';



class CertificationResult extends ConsumerWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  final Map<String, String>? result;

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

    if(ref.read(signupUserProvider.notifier).isSignup == true){
      return;
    }

    print('nuya Second');

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
          wedCd: state.wedCd,
          genderCd: state.genderCd,
          occpSidoCd: state.occpSidoCd,
          occpSigunguCd: state.occpSigunguCd,
          houseTpCd: state.housTpCd,
          birthday: state.birthday,
          uniqueKey: state.uniqueKey,
          certifiedAt: state.certifiedAt,
          phoneNumber: state.phoneNumber,
          userName: state.userName,
          industryCd: state.industryCd,
          industryDetailCd: state.industryDetailCd,
          taskCd: state.taskCd,
        );
        try {
          var dio = Dio();
          final firebaseToken = await readTokenFromSecureStorage();
          print('회원가입시 firebaseToken: $firebaseToken');
          var response = await dio.post(
            '$ip/api/user/save',
            data: {
              "birthday": newUser.birthday,
              "email": newUser.email,
              "userName": newUser.userName,
              "password": newUser.password,
              'firebaseToken': firebaseToken,
              "uniqueKey": newUser.uniqueKey,
              "certifiedAt": newUser.certifiedAt,
              "phoneNumber": newUser.phoneNumber,
              "jobCd": newUser.jobCd,
              "wedCd": newUser.wedCd,
              "genderCd": newUser.genderCd,
              "occpSidoCd": newUser.occpSidoCd,
              "occpSigunguCd": newUser.occpSigunguCd,
              "housTpCd": newUser.houseTpCd,
              "isTermsAgreed": newUser.isTermsAgreed,
              "isPrivacyAgreed": newUser.isPrivacyAgreed,
              "taskCd": newUser.taskCd,
              "industryCd": newUser.industryCd,
              "industryDetailCd": newUser.industryDetailCd,
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json;charset=utf-8',
              },
            ),
          );
          print('성공적 수행');
          if (response.statusCode == 201 || response.statusCode == 200) {
            print('nugi${response.statusCode}');
            var accessToken = response.headers.value('Authorization');
            var refreshToken = response.headers.value('Authorization-refresh');
            print('accessToken: $accessToken');
            print('refreshToken: $refreshToken');

            await flutterSecureStorage.write(
                key: REFRESH_TOKEN_KEY, value: refreshToken);
            await flutterSecureStorage.write(
                key: ACCESS_TOKEN_KEY, value: accessToken);
            ref.read(userMeProvider.notifier).getMe();
            ref.read(signupUserProvider.notifier).setIsSignupAction(true);
          }
          else if(response.statusCode == 500){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('알림'),
                  content: Text('네트워크 에러입니다. 다시 인증해 주세요!'),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text('확인'),
                      onPressed: () {
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                    ),
                  ],
                );
              },
            );
          }

        } catch (e) {
          print('debg22');
          ref.read(signupUserProvider.notifier).setIsSignupAction(true);
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
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                      Navigator.of(context).pop(); // 다이얼로그 닫기
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text('알림'),
                content: Text('네트워크 에러입니다. 다시 인증해 주세요!'),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    },
                  ),
                ],
              );
            },
          );
        print('아임포트 쪽 에러');
        print('Request failed with status: ${response.statusCode}.');
      }
    }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AlertDialog를 표시하는 공통 함수

    FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

    print('buildTime');

    if (result!['success'] == 'true' && ref.read(signupUserProvider.notifier).isSignup == false) {
      print('herePoint${ref.read(signupUserProvider.notifier).isSignup}');
      final accessTokenKey = dotenv.env['KG_INICIS_ACCESS_TOKEN_KEY'];
      final accessTokenSecret = dotenv.env['KG_INICIS_ACCESS_TOKEN_SECRET'];
      getAccessToken(accessTokenKey!,
              accessTokenSecret!)
          .then((accessToken) => getCertificationResult(result!['imp_uid']!,
              accessToken, context, ref, flutterSecureStorage));
    }
    return SplashScreen(
      message: '잠시만 기다려주세요...',
    );
  }
}
