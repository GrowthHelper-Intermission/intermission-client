import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleFormWebView extends StatefulWidget {
  final VoidCallback onComplete;

  GoogleFormWebView({required this.onComplete});
  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}

final homeUrl = Uri.parse(
    'https://docs.google.com/forms/d/1AkYT38aaIB9ACx1C60xcbzGJxF_BHTyRebaZt2_QPsQ/viewform?edit_requested=true&pli=1');

final _completionURL =
    'https://docs.google.com/forms/u/2/d/e/1FAIpQLSdMOssE_VzRdeKVid0UlNDAtuxYLuN6uMVy-_zJIreNr7ZBmA/formResponse?pli=1';

final commitTest = 2;

class _GoogleFormWebViewState extends State<GoogleFormWebView> {
  late WebViewController controller;  // 수정된 부분

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(homeUrl)
      ..setNavigationDelegate(
        NavigationDelegate(
            onNavigationRequest: (request){
              if (request.url.startsWith(_completionURL)) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  _showCompletionDialog();
                });
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            }
        ),
      );
  }

  void _showCompletionDialog() {  // AlertDialog를 띄우는 함수
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
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
