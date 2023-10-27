
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/* 아임포트 휴대폰 본인인증 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_certification.dart';
/* 아임포트 휴대폰 본인인증 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:intermission_project/01.user/user/view/certification_result.dart';

class CertificationTest extends StatelessWidget {
  const CertificationTest({super.key});

  static String get routeName => 'certification-test';
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: AppBar(
        title: Text('아임포트 본인인증!'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp34178186',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData(
        mid: 'INIiasTest',
        reqSvcCd: "01",
        mTxId: "test_20210625",
        authHash: 'ccfb95d2b12265c0b2144a2c76e30ff305cacc02e027390496d2edeab92c25d8',
        flgFixedUser: "N",
        userName: "홍길동",
        userPhone: "01011112222",
        userBirth: "19800101",
        userHash: '',
        directAgency: '',
        successUrl: 'http://localhost/sasample/PHP/success.php',
        failUrl: 'http://localhost/sasample/PHP/success.php',
        mRedirectUrl: 'http://localhost/sasample/PHP/success.php',
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
        company: '아임포트',                                            // 회사명 또는 URL
        carrier: 'SKT',                                               // 통신사
        name: '홍길동',                                                 // 이름
        phone: '01012341234',                                         // 전화번호
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        try {
          if (result['success'] == 'true') {
            print(result['success']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CertificationResult(result:result),
              ),
            );
            print('wee');
          } else {
            // 본인 인증 실패 또는 취소
            Navigator.pop(context); // 이전 페이지로 돌아갑니다
          }
        }catch(e){
          print(e);
        }
      },
    );
  }
}