import 'package:get/get.dart';
import 'package:kkguoji/pages/withdraw/withdraw_logic.dart';

class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WithdrawLogic>(() => WithdrawLogic());
  }
}
