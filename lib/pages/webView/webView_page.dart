
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    ConfigService.to.toggleButtonVisibility(false);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    ConfigService.to.toggleButtonVisibility(true);
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage) {})
      ..loadRequest(Uri.parse(Get.arguments));

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: TextButton(
              onPressed: () {
                RouteUtil.popView();
              },
              child: Image.asset(
                "assets/images/back_normal.png",
                width: 40,
                height: 40,
              )),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
