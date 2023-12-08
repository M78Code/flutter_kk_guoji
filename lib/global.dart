
import 'package:get/get.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/services/http_service.dart';

class Global {
  static Future<void> init() async {

    Get.put<UserService>(UserService());
    Get.put<HttpService>(HttpService());
  }
}