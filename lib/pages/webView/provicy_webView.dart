import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/route_util.dart';

class KKPrivacyPage extends StatelessWidget {
  const KKPrivacyPage( {super.key});

  @override
  Widget build(BuildContext context) {
    // WebViewController controller = WebViewController()..setBackgroundColor(const Color(0xFF171A26))
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage) {})
    //   ..loadFile(Assets.htmlRegisterProtocol);
    List list = Get.arguments;
    return Scaffold(
      appBar: KKCustomAppBar(list.first),
      body: InAppWebView(
        initialFile: list.last,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(transparentBackground: true),
        ),
        // onWebViewCreated: (controller) {
        //   webViewController = controller;
        // },
        // onScrollChanged: (InAppWebViewController controller, int x, int y) {
        //   _checkWebViewIfBottom(y);
        // },
      ),
    );
  }
}
