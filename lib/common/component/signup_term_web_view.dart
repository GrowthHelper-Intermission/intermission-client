import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController();
    controller.loadRequest(Uri.parse(widget.homeUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
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
