import 'package:get/get.dart';
import 'package:kkguoji/pages/recharge/recharge_logic.dart';

class RechargeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<RechargeLogic>(() => RechargeLogic());
  }
}
