import 'package:get/get.dart';
import 'package:kkguoji/pages/account/email/email_logic.dart';

class EmailBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<EmailLogic>(() => EmailLogic());
  }
}
