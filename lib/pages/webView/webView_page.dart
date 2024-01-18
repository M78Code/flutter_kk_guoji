
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../services/config_service.dart';
import '../../utils/route_util.dart';


class KKWebViewPage extends StatefulWidget {
  const KKWebViewPage({super.key});
  @override
  State<KKWebViewPage> createState() => _KKWebViewPageState();
}

class _KKWebViewPageState extends State<KKWebViewPage> {

  @override
  Widget build(BuildContext context) {
    String url = "";
    if(Get.arguments is List) {
      List args = Get.arguments;
      url = args.first;
    }else {
      url = Get.arguments;
    }
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(FkUserAgent.userAgent)
      ..addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage) {})
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: const KKCustomAppBar(""),
      body: WebViewWidget(controller: controller),
    );
  }
}
