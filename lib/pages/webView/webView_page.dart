
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
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

  String? gameId;
  String? gameType;

  @override
  Widget build(BuildContext context) {
    String url = "";
    if(Get.arguments is String) {
      url = Get.arguments;
    }else {
      List args = Get.arguments;
      url = args.first;
      gameId = args[1].toString();
      gameType = args.last;
    }


    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("flutter", onMessageReceived: (JavaScriptMessage jsMessage) {})
      ..loadRequest(Uri.parse(url));
    final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        userAgent: FkUserAgent.userAgent!,
      ),

      /// android 支持HybridComposition
      // android: AndroidInAppWebViewOptions(
      //   useHybridComposition: true,
      // ),
      // ios: IOSInAppWebViewOptions(
      //   allowsInlineMediaPlayback: true,
      // ),
    );

    return Scaffold(
      appBar: const KKCustomAppBar("博赢国际"),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(url)),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
              allowContentAccess: true,
              builtInZoomControls: true,
              thirdPartyCookiesEnabled: true,
              allowFileAccess: true,
              supportMultipleWindows: true
          ),
          crossPlatform: InAppWebViewOptions(
            verticalScrollBarEnabled: true,
            supportZoom: false,
            clearCache: true,
            disableContextMenu: false,
            cacheEnabled: true,
            javaScriptEnabled: true,
            javaScriptCanOpenWindowsAutomatically: true,
            // disableHorizontalScroll: false,
            // disableVerticalScroll: false,

            // debuggingEnabled: true,
            transparentBackground: true,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(Get.arguments is List) {
      logoutGame();
      if(gameType == "COG"){
        logoutCOG();
      }
    }
  }

  void logoutGame() async{
    if(gameId != null) {
      var result = await HttpRequest.request(
          HttpConfig.gameLogOut, method: "post",
          params: {"game_id": int.parse(gameId!)});
    }
  }

  void logoutCOG() async{
    if(gameId != null) {
      var result = await HttpRequest.request(
          HttpConfig.logoutCOG);
    }
  }

}
