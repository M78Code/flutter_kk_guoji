
import 'package:get/get.dart';

class RegisterLogic extends GetxController {


  final RxBool isAccount = true.obs;
  final RxBool isAgree = false.obs;
  final RxBool isCanRegister = false.obs;
  final RxBool psdObscure = true.obs;
  final RxBool verPsdObscure = true.obs;

  String accountText = "";
  String passwordText = "";
  String verPsdText = "";
  String inviteText = "";

  int registerType = 1;


  setRegisterType(int type) {
    if(type == registerType) {
      return;
    }else {
      registerType = type;
      if(registerType == 1) {
        isAccount.value = true;
      }else {
        isAccount.value = false;
      }
    }
  }

  clickAgreeBtn() {
    isAgree.value = !isAgree.value;
  }

  showPassword() {
    psdObscure.value = !psdObscure.value;
  }

  showVerPassword() {
    verPsdObscure.value = !verPsdObscure.value;
  }
}