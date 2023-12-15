import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_logic.dart';

class MyAccountBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MyAccountLogic>(() => MyAccountLogic());
  }
}
