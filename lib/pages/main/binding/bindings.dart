import 'package:get/get.dart';
import 'package:kkguoji/base/logic/gloabal_state_controller.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';

class mainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => GlobalStateController());
    Get.lazyPut(()=> MainPageLogic());
    Get.lazyPut(() => HomeLogic());
  }
}