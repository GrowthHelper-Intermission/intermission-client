import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intermission_project/common/view/root_tab.dart';

class CertificationResult extends StatelessWidget {
  static const Color successColor = Color(0xff52c41a);
  static const Color failureColor = Color(0xfff5222d);

  // final Map<String,String> result;
  //
  // const CertificationResult({super.key, required this.result});



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

  Future<void> getCertificationResult(String impUid, String accessToken,BuildContext context) async {
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RootTab()),
        );
      Get.offAllNamed('/home');
      // Get.offAllNamed('/');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, String> result = context as Map<String, String>;
    Map<String, String> result = Get.arguments as Map<String, String>;
    String message;
    IconData icon;
    Color color;
    bool isErrorMessageRendering;

    print(result);

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
          getCertificationResult(result!['imp_uid']!, accessToken, context);
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
