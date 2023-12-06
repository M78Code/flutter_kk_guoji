import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';

class mainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> MainPageLogic());
    Get.lazyPut(() => HomeLogic());
  }
}