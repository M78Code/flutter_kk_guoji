import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/activity_logic.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ActivityLogic());
  }
}