import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/binding.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class GoogleFormWebView extends StatefulWidget {
  final VoidCallback onComplete;
  final String homeUrl;
  final String completionURL;
  final int page; // 페이지 수를 나타내는 변수

  GoogleFormWebView({
    required this.onComplete,
    required this.homeUrl,
    required this.completionURL,
    required this.page,
  });

  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}

class _GoogleFormWebViewState extends State<GoogleFormWebView> {
  late WebViewController controller;
  int pageReachedCount = 0;
  int currentHistoryLength = 0; // 현재 페이지의 히스토리 길이를 저장하는 변수

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

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              pageReachedCount++;
              if (pageReachedCount == widget.page) {
                print('설문 완료');
                widget.onComplete();
                _showCompletionDialog();
              }
            }
            print(progress);
          },
          onPageStarted: (String url) {
            print(url);
          },
          onPageFinished: (String url) {
            print(url);
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.toString()}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith(widget.completionURL)) {
            //
            //   widget.onComplete();
            //   _showCompletionDialog();
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.homeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar(title: '구글폼'),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
