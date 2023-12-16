import 'package:flutter/material.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class GoogleFormWebView extends StatefulWidget {
  final VoidCallback onComplete;
  final String homeUrl;

  GoogleFormWebView({
    required this.onComplete,
    required this.homeUrl,
  });

  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}


class _GoogleFormWebViewState extends State<GoogleFormWebView> {
  late WebViewController controller;
  bool isLoading = false; // 로딩 상태를 관리하는 변수
  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('참여 완료'),
        content: Text('참여가 완료되었습니다!'),
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }


  Future<bool> checkFormFilledStatus(WebViewController controller) async {
    var result = await controller.runJavaScriptReturningResult("document.getElementsByClassName('vHW8K').length > 0");
    return result == true;
  }


  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
            print(url);
          },
          onPageFinished: (String url) async {
            print(url);
            bool isFormFilled = await checkFormFilledStatus(controller);
            print(isFormFilled);
            if (isFormFilled) {
              _showCompletionDialog();
              widget.onComplete();
            }
            // setState(() {
            //   isLoading = false;
            // });
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.toString()}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.homeUrl));
  }


  @override
  Widget build(BuildContext context) {
    if(!isLoading) return SplashScreen(message: '외부 폼으로 이동중...',);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _showExitConfirmation,
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('설문 응답 종료'),
        content: Text('설문 응답을 그만두시겠습니까?'),
        actions: <Widget>[
          TextButton(
            child: Text('이어하기'),
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그만 닫음
            },
          ),
          TextButton(
            child: Text('그만두기'),
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              Navigator.of(context).pop(); // 웹뷰 화면에서 이전 화면으로 돌아감
            },
          ),
        ],
      ),
    );
  }
}
