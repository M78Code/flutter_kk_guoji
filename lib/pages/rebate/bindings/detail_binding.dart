

import 'package:get/get.dart';
import 'package:kkguoji/pages/rebate/logic/detail_logic.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DetailLogic());
  }
}