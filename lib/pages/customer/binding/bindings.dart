
import 'package:get/get.dart';
import 'package:kkguoji/pages/customer/logic/logic.dart';

import '../logic/logic.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CustomerLogic());
  }
}