import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/route_util.dart';

class KKWebViewPage extends StatelessWidget {
  const KKWebViewPage( {super.key});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()..loadRequest(Uri.parse(Get.arguments));

    controller.addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage){

    });
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: TextButton(onPressed: (){
            RouteUtil.popView();
          }, child: Image.asset("assets/images/back_normal.png", width: 40, height: 40,)),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }

}
