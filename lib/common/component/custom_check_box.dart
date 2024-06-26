import 'package:flutter/material.dart';
import 'package:intermission_project/common/view/splash/middle_splash_web_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isAgree;
  final ValueChanged<bool?> onChanged;
  final String title;
  final bool? isArrow;
  final Color? color;
  final double? fontSize;
  final bool? isDetail;
  final String? url;

  const CustomCheckBox({
    Key? key, // Best practice: always add a Key parameter to stateless widgets
    this.url,
    this.fontSize,
    this.color,
    this.isDetail,
    required this.isAgree,
    required this.onChanged,
    required this.title,
    this.isArrow = false, // Default value is false if not provided
  }) : super(key: key); // Pass key to the super constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 30,
            child: Checkbox(
              value: isAgree,
              activeColor: color ?? Colors.green,
              checkColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize ?? 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  width: 260,
                ),
                if (isDetail ?? false)
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MiddleSplashWebView(
                            homeUrl: url ??
                                'https://docs.google.com/document/d/e/2PACX-1vTNbqTr-co8U-S9KnXI3ruFGz1FEnv5GymdwX7hvRrFI4ewsOWVQGlTgsc7nIIpXrtz-gVLJfLjzAXd/pub',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '[내용보기]',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: GREY_COLOR),
                    ),
                  )
              ],
            ),
          ),
          if (isArrow ?? false) // isArrow가 null이 아니고 true일 경우에만 IconButton을 표시
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 20),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewScreen()),
                // );
              },
            ),
          // 조건이 거짓이라면 아무것도 표시하지 않음
        ],
      ),
    );
  }
}
