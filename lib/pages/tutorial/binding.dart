import 'package:get/get.dart';

import 'logic.dart';

class TutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TutorialLogic());
  }
}
