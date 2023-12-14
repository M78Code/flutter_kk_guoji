import 'package:get/get.dart';
import 'package:kkguoji/pages/rebate/logic/logic.dart';

class KKRebateBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => KKRebateLogic());
  }
}