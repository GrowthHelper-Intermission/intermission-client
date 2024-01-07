import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/signup_term_web_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/const/data.dart';

import '../../layout/default_layout.dart';

class IntermissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '인터미션 정보',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TEXT_GREY_COLOR,
                    ),
                    color: Colors.white, // 배경색 설정
                    borderRadius: BorderRadius.circular(6), // 모서리 둥글게 설정
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '약관 및 정책',
                          style: greyBigTextStyle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '버전 정보',
                              style: blackSmallTextStyle,
                            ),
                            Text(
                              '1.1.0',
                              style: primarySmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () async{
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignupTermWebView(
                                  homeUrl: serviceUrl,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '서비스 이용약관',
                                style: blackSmallTextStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: GREY_COLOR,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () async{
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignupTermWebView(
                                  homeUrl: privateUrl,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '개인정보 처리방침',
                                style: blackSmallTextStyle,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: GREY_COLOR,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TEXT_GREY_COLOR,
                    ),
                    color: Colors.white, // 배경색 설정
                    borderRadius: BorderRadius.circular(6), // 모서리 둥글게 설정
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/company_logo.png',
                          width: 400,
                          height: 100,
                        ),
                        Text(
                          '회사',
                          style: greyBigTextStyle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '상호명',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •  주식회사 그로스헬퍼',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '대표',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •  조용우',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '개인정보보호책임자',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •  조용우',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        //      '주소  •  서울특별시 중구 퇴계로36길 2',
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '주소',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •  서울특별시 중구 퇴계로36길 2',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '사업자전화번호',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •   010-2923-3989',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '사업자등록번호',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •   783-08-02419',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              '이메일',
                              style: greyMiddleTextStyle,
                            ),
                            Text(
                              '  •   dyddnayrma@naver.com',
                              style: blackSmallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
