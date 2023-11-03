import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/view/default_layout.dart';

class ShoppingDetailScreen extends StatefulWidget {
  const ShoppingDetailScreen({super.key});

  @override
  State<ShoppingDetailScreen> createState() => _ShoppingDetailScreenState();
}

class _ShoppingDetailScreenState extends State<ShoppingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              child: Image.asset(
                'assets/img/bigCash.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '현금 교환',
                    style: whiteSmallTextStyle,
                  ),
                  Text(
                    '2000P',
                    style: customCashStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '교환 예정일',
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        '현재일 기준 3일 이내',
                        style: blackSmallTextStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '받으실 곳',
                        style: whiteSmallTextStyle,
                      ),
                      Text(
                        '현재일 기준 3일 이내',
                        style: blackSmallTextStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                    child: Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                  //아래 상자부터 UI작업 시작
                  SizedBox(
                    child: Column(
                      children: [

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle customCashStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 24.0,
  color: Colors.black,
);
