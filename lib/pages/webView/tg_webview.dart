import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/route_util.dart';

class TGWebview extends StatelessWidget {
  const TGWebview( {super.key});

  @override
  Widget build(BuildContext context) {
    final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),

      /// android 支持HybridComposition
      // android: AndroidInAppWebViewOptions(
      //   useHybridComposition: true,
      // ),
      // ios: IOSInAppWebViewOptions(
      //   allowsInlineMediaPlayback: true,
      // ),
    );
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
      body: InAppWebView(
        initialOptions: options,
        shouldOverrideUrlLoading: (controller, action) async{
          return NavigationActionPolicy.ALLOW;
        },
        initialUrlRequest: URLRequest(url: Uri.parse(Get.arguments),


        ),
      )
    );
  }

}
