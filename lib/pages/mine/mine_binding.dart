import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/mine_logic.dart';

class MineBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MineLogic>(() => MineLogic());
  }
}
