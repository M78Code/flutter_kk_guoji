import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/register/logic.dart';
import 'package:kkguoji/routes/routes.dart';

import '../../utils/route_util.dart';

class TGWebview extends StatelessWidget {
  TGWebview( {super.key});
  late InAppWebViewController _webViewController;

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


    return Scaffold(
      // appBar: AppBar(
      //   leading: SizedBox(
      //     width: 50,
      //     height: 50,
      //     child: TextButton(onPressed: (){
      //       RouteUtil.popView();
      //     }, child: Image.asset("assets/images/back_normal.png", width: 40, height: 40,)),
      //   ),
      //   title: const Text("Telegram登录", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
      // ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse("https://testh502.759pc.com/pages/tg-auth/tg-auth?platform=flutter")),
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
            clearCache: true,
            disableContextMenu: false,
            cacheEnabled: true,
            javaScriptEnabled: true,
            javaScriptCanOpenWindowsAutomatically: true,
            // debuggingEnabled: true,
            transparentBackground: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
          _webViewController.addJavaScriptHandler(handlerName: "handlerTgAuthCallback", callback: (dynamic){

          });
        },
        onCreateWindow: (controller, createWindowRequest) async {
          _webViewController.addJavaScriptHandler(handlerName: "handlerTgAuthCallback", callback: (dynamic) async{
            String tgStr = dynamic.first.toString();
            Map tgMap = json.decode(tgStr);
           bool isSuccess = await Get.find<RegisterLogic>().registerWithTg(tgMap, tgStr);
           if(isSuccess) {
             RouteUtil.pushToView(Routes.mainPage, offAll: true);
           }else {
             controller.reload();
           }
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 400,
                  child: InAppWebView(
                    // Setting the windowId property is important here!
                    windowId: createWindowRequest.windowId,
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        builtInZoomControls: true,
                        thirdPartyCookiesEnabled: true,
                      ),
                      crossPlatform: InAppWebViewOptions(
                        cacheEnabled: true,
                        javaScriptEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (
                        InAppWebViewController controller) {
                      controller.addJavaScriptHandler(handlerName: "handlerTgAuthCallback", callback: (dynamic){

                      });

                    },
                    onLoadStart: (InAppWebViewController controller,
                        url) {
                      // print("onLoadStart popup $url");
                    },
                    onLoadStop: (InAppWebViewController controller,
                        url) async {
                      // print("onLoadStop popup $url");
                    },
                    onCloseWindow: (controller) {
                      // On Facebook Login, this event is called twice,
                      // so here we check if we already popped the alert dialog context
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              );
            },
          );

          return true;
        },
      )
    );
  }

}
