import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KKWebViewPage extends StatelessWidget {
  const KKWebViewPage( {super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()..loadRequest(Uri.parse(Get.arguments));
    return Scaffold(
      body: WebViewWidget(controller: controller,),
    );
  }
}
