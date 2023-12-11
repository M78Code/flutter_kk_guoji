import 'package:get/get.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';

///提现控制类
class WithdrawLogic extends GetxController {
  final ImageRadioController imageController = ImageRadioController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    imageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
