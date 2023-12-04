import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';

class mainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeLogic());
  }
}