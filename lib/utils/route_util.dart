import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';

class RouteUtil {
  static void pushToView(String pageName, {dynamic arguments, bool offAll = false, bool offLast = false, ValueChanged<dynamic>? onBack}) {

    if (offAll == true) {
      Get.offAllNamed(pageName, arguments: arguments)?.then((value) {
        if (onBack != null) {
          onBack(value);
        }
      });
    } else if (offLast == true) {
      Get.offNamed(pageName, arguments: arguments)?.then((value) {
        if (onBack != null) {
          onBack(value);
        }
      });
    } else {
      Get.toNamed(pageName, arguments: arguments)?.then((value) {
        if (onBack != null) {
          onBack(value);
        }
      });
    }
  }

  static void popView({dynamic result}) {
    Get.back(result: result);
  }
}
