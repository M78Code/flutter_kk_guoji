import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';

import '../logic/item_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => ItemLogic());
  }
}