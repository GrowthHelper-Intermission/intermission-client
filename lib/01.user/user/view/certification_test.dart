
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:intermission_project/01.user/user/view/certification_result.dart';

class CertificationTest extends StatelessWidget {
  const CertificationTest({super.key});

  static String get routeName => 'certification-test';
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: AppBar(
        title: Text('아임포트 본인인증'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/iamportLogo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: '${dotenv.env['IDENTIFICATION_MID']}',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData(
        company: '인터미션',
        name: '이도형',
        mRedirectUrl: 'http://localhost/sasample/PHP/success.php',
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
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
          } else {
            print(result);
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