import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  static const String userCode = 'imp34178186';
  static String get routeName => 'Certification';

  @override
  Widget build(BuildContext context) {
    CertificationData data = context as CertificationData;

    print(data);

    return IamportCertification(
      appBar: AppBar(
        title: Text('아임포트 본인인증2'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      initialChild: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        print('why@@');
        //못돌아오게 pushReplacementNamed, queryParameters, pathParameters 헷갈
        context.pushReplacementNamed('/certification-result');
      },
    );
  }
}
