
import 'package:get/get.dart';

class LoginLogic extends GetxController {

  final RxBool psdObscure = true.obs;
  final RxBool savePassword = false.obs;
  final RxBool canLogin  = false.obs;


  showPassword() {
    psdObscure.value = !psdObscure.value;
  }

  clickSavePasswordBtn() {
    savePassword.value = !savePassword.value;
  }
}