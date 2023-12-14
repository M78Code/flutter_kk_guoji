
import 'package:get/get.dart';
import 'package:kkguoji/pages/promotion/logic/promotion_logic.dart';

class PromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionLogic());  }

}