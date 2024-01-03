import 'package:flutter/material.dart';
import 'package:intermission_project/common/view/splash_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignupTermWebView extends StatefulWidget {
  final String homeUrl;

  SignupTermWebView({
    required this.homeUrl,
  });

  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}

class _GoogleFormWebViewState extends State<SignupTermWebView> {
  late WebViewController controller;
  bool isLoading = true; // 로딩 상태 변수 추가

  @override
  void initState() {
    // TODO: implement initState
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
            setState(() {
              isLoading = false;
            });
            print(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.toString()}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    controller.loadRequest(Uri.parse(widget.homeUrl));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SplashScreen(message: '잠시만 기다려주세요...',);
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      );
    }
  }
}
