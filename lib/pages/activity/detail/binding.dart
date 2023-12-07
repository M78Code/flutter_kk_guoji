import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/activity_logic.dart';

import 'logic.dart';

class ActivityDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ActivityDetailLogic());
  }
}