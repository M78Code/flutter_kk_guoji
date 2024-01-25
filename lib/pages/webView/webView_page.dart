
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

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage) {})
      ..loadRequest(Uri.parse(Get.arguments));

    return Scaffold(
      appBar: const KKCustomAppBar("博赢国际"),
      body: WebViewWidget(controller: controller),
    );
  }
}
