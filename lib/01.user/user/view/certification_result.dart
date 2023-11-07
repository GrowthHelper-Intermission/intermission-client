import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/view/certification_result_provider.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/01.user/user/view/signup_screen_page3.dart';
import 'package:intermission_project/common/const/data.dart';
import 'dart:convert';
import 'package:intermission_project/common/view/splash_screen.dart';

import '../../../common/view/select_screen.dart';

class CertificationResult extends ConsumerWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  final Map<String, String> result;

  bool _isGetCertificationResultCalled = false;

  /// 1

  CertificationResult({super.key, required this.result});

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

  Future<void> getCertificationResult(String impUid, String accessToken,
      BuildContext context, WidgetRef ref) async {
    var url = Uri.parse('https://api.iamport.kr/certifications/$impUid');

    print(impUid);

    print(2);

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': accessToken,
      },
    );

    /// Iamport에서 성공적으로 데이터받아왓다면
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      var data = json.decode(response.body);
      var responseData = data['response'];

      // 필요한 데이터 추출
      String? birthday = responseData['birthday'];
      String? uniqueKey = responseData['uniqueKey'];
      int? certifiedAt = responseData['certified_at'];
      String? phoneNumber = responseData['phone'];
      String? userName = responseData['name'];

      // 상태 변경
      final state = ref.read(signupUserProvider.notifier);
      state.setBirthday(birthday);
      state.setUniqueKey(certifiedAt.toString());
      state.setCertifiedAt(certifiedAt.toString());
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
        petCd: "강아지",
        occpSidoCd: state.occpSidoCd,
        occpSigunguCd: state.occpSigunguCd,
        houseTpCd: state.housTpCd,
        userCd: state.userCd,
        birthday: state.birthday,
        uniqueKey: state.certifiedAt,
        certifiedAt: state.certifiedAt,
        phoneNumber: state.phoneNumber,
        userName: state.userName,
      );
      try {
        print('hmm');
        var dio = Dio();
        var data = newUser.toJson();

        /// 여기까지 정상수행
        ///
        var response = await dio.post(
          'https://$ip/api/user/save',
          data: {
            "birthday": newUser.birthday,
            "email": newUser.email,
            "userName": newUser.userName,
            "password": newUser.password,
            // 1699339688.toString() -> 중복계정 테스트할때
            "uniqueKey": newUser.uniqueKey.toString(),
            "certifiedAt": newUser.certifiedAt.toString(),
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
        final notifier = ref.read(certificationResultProvider.notifier);
        notifier.setLoading(false);
        notifier.setSuccess(true);
      } catch (e) {
        print(e);
        final notifier = ref.read(certificationResultProvider.notifier);
        notifier.setLoading(false);
        notifier.setSuccess(false);
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

    String message;
    IconData icon;
    Color color;
    bool isErrorMessageRendering;

    if (result!['success'] == 'true') {
      message = '본인인증에 성공하였습니다';
      icon = Icons.check_circle;
      color = successColor;
      isErrorMessageRendering = false;

      if (!_isGetCertificationResultCalled) {
        _isGetCertificationResultCalled = true;
        getAccessToken(
          '1188833256121578',
          'WqgqCGlYJPB9e5j7bpTsPPMDhZP7mdncthivWfKYDrcDRpXYbCCphRqkEwqfcLXZMJ0TVl2h2E6XXJhk',
        ).then(
          (accessToken) {
            print('iamport accessToken: $accessToken');
            getCertificationResult(
              result!['imp_uid']!,
              accessToken,
              context,
              ref,
            );
          },
        );
      }
    } else {
      message = '본인인증에 실패하였습니다';
      icon = Icons.error;
      color = failureColor;
      isErrorMessageRendering = true;
    }

    void navigateToScreen(Widget screen) {
      Future.delayed(Duration(seconds: 1), () {
        // Wait for 2 seconds
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => screen,
        ));
      });
    }

    if (certificationState.isLoading && !certificationState.isSuccess) {
      return SplashScreen();
    } else if (!certificationState.isSuccess && !certificationState.isLoading) {
      navigateToScreen(
        SignupScreenPage3(),
      );
      return Scaffold(
        appBar: AppBar(
          title: Text('본인인증 결과'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: AlertDialog(
          title: Text('중복 회원'),
          content: Text('중복된 회원입니다. 다시 회원가입 해주세요!'),
        ),
      );
    } else {
      navigateToScreen(
        LoginScreen(),
      );
      return Scaffold(
        appBar: AppBar(
          title: Text('본인인증 결과'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: AlertDialog(
          title: Text('회원가입 완료'),
          content: Text('로그인 해주세요!'),
        ),
      );
    }
  }
}
