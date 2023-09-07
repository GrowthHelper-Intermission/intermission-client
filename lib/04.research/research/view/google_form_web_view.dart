// import 'package:flutter/material.dart';
// import 'package:flutter/src/scheduler/binding.dart';
// import 'package:intermission_project/common/component/normal_appbar.dart';
// import 'package:intermission_project/common/const/colors.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// // Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// // Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
//
// class GoogleFormWebView extends StatefulWidget {
//   final VoidCallback onComplete;
//
//   GoogleFormWebView({required this.onComplete});
//   @override
//   _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
// }
//
// const homeUrl =
//     'https://docs.google.com/forms/d/1AkYT38aaIB9ACx1C60xcbzGJxF_BHTyRebaZt2_QPsQ/viewform?edit_requested=true&pli=1';
//
// const _completionURL =
//     'https://docs.google.com/forms/d/e/1FAIpQLSdMOssE_VzRdeKVid0UlNDAtuxYLuN6uMVy-_zJIreNr7ZBmA/formResponse?pli=1';
//
// final commitTest = 2;
//
//
// class _GoogleFormWebViewState extends State<GoogleFormWebView> {
//   late WebViewController controller;
//
//   void _showCompletionDialog() {  // AlertDialog를 띄우는 함수
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('참여 완료'),
//         content: Text('참여가 완료되었습니다!'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('확인'),
//             onPressed: () {
//               Navigator.of(context).pop();  // AlertDialog를 닫습니다.
//               Navigator.of(context).pop();  // 웹뷰 페이지를 닫습니다.
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             print(progress);
//           },
//           onPageStarted: (String url){
//             print(url);
//           },
//           onPageFinished: (String url){
//             print(url);
//           },
//           onWebResourceError: (WebResourceError error) {
//             print('Web resource error: ${error.toString()}');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith(_completionURL)) {
//               print('hello');
//               widget.onComplete();  // 여기서 콜백 호출
//               _showCompletionDialog();
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )..loadRequest(Uri.parse(homeUrl.toString()));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NormalAppbar(title: '구글폼'),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }




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

  GoogleFormWebView({
    required this.onComplete,
    required this.homeUrl,
    required this.completionURL,
  });

  @override
  _GoogleFormWebViewState createState() => _GoogleFormWebViewState();
}

class _GoogleFormWebViewState extends State<GoogleFormWebView> {
  late WebViewController controller;

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
            if (request.url.startsWith(widget.completionURL)) {
              print('hello');
              widget.onComplete();
              _showCompletionDialog();
              return NavigationDecision.prevent;
            }
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
