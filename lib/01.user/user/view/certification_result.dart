import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intermission_project/01.user/user/model/signup_user_model.dart';
import 'package:intermission_project/01.user/user/provider/signup_user_provider.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/01.user/user/view/login_screen.dart';
import 'package:intermission_project/common/const/data.dart';
import 'dart:convert';

import 'package:intermission_project/common/view/root_tab.dart';

class CertificationResult extends ConsumerWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  final Map<String, String> result;

  const CertificationResult({super.key, required this.result});

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

      print('birthday: $birthday');
      print('uniqueKey: $uniqueKey');
      print('certifiedAt: $certifiedAt');
      print('phoneNumber: $phoneNumber');
      print('userName: $userName');
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

        ///error point
        occpSidoCd: state.occpSidoCd,
        occpSigunguCd: state.occpSigunguCd,
        houseTpCd: state.housTpCd,
        userCd: state.userCd,

        birthday: state.birthday,
        uniqueKey: "24241310",
        certifiedAt: "24241310",
        phoneNumber: state.phoneNumber,
        userName: state.userName,
      );
      try {
        print('hmm');
        print(newUser.email);
        print(newUser.password);
        print(newUser.isTermsAgreed);
        print(newUser.isPrivacyAgreed);

        print(newUser.jobCd);
        print(newUser.asignJobCd);
        print(newUser.wedCd);
        print(newUser.genderCd);
        print(newUser.petCd);
        print(newUser.occpSidoCd);
        print(newUser.occpSigunguCd);
        print(newUser.houseTpCd);
        print(newUser.userCd);

        print(newUser.birthday);
        print(newUser.uniqueKey);
        print(newUser.certifiedAt);
        print(newUser.phoneNumber);
        print(newUser.userName);

        // ref.read(userMeProvider.notifier).postUser(newUser);
        var dio = Dio();
        var data = newUser.toJson();
        print('h');
        print(data);
        var response = await dio.post(
          'https://$ip/api/user/save',
          data: {
            "birthday": newUser.birthday,
            "email": newUser.email,
            "userName": newUser.userName,
            "password": newUser.password,
            "uniqueKey": newUser.uniqueKey,
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
        print('why');
        print(response);
        print('why2');
        if (response.statusCode == 201) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        }
        print('성공적 수행??????');
      } catch (e) {
        print(e);
        print('sibal');
        print('에러');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String message;
    IconData icon;
    Color color;
    bool isErrorMessageRendering;

    // print(result);

    if (result!['success'] == 'true') {
      message = '본인인증에 성공하였습니다';
      icon = Icons.check_circle;
      color = successColor;
      isErrorMessageRendering = false;

      getAccessToken('1188833256121578',
              'WqgqCGlYJPB9e5j7bpTsPPMDhZP7mdncthivWfKYDrcDRpXYbCCphRqkEwqfcLXZMJ0TVl2h2E6XXJhk')
          .then(
        (accessToken) {
          print(accessToken);
          getCertificationResult(
              result!['imp_uid']!, accessToken, context, ref);
        },
      );
    } else {
      message = '본인인증에 실패하였습니다';
      icon = Icons.error;
      color = failureColor;
      isErrorMessageRendering = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('본인인증 결과'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 200,
            ),
            Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            // ... (other parts of your code remain unchanged)
          ],
        ),
      ),
    );
  }
}
