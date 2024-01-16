
// 自定义的路由观察器
import 'package:flutter/cupertino.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/config_service.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == Routes.webView
        || route.settings.name == Routes.customer ||route.settings.name == Routes.tgWebView) {
      ConfigService.to.toggleButtonVisibility(false);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == Routes.webView
        || route.settings.name == Routes.customer || route.settings.name == Routes.tgWebView) {
      ConfigService.to.toggleButtonVisibility(true);
    }
  }
}