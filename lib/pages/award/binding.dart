import 'package:get/get.dart';

import 'logic.dart';

class AwardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AwardLogic());
  }
}
