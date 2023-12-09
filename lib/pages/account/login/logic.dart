
import 'package:get/get.dart';
import 'package:kkguoji/base/logic/gloabal_state_controller.dart';
import 'dart:math';

import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:kkguoji/common/widget/show_toast.dart';

class LoginLogic extends GetxController {

  final RxBool psdObscure = true.obs;
  final RxBool savePassword = false.obs;
  final RxBool canLogin  = false.obs;

  final globalController = Get.find<GlobalStateController>();


  final RxList<int> verCodeImageBytes = RxList<int>();

  String code_value = "";
  String verCodeText = "";
  String accountText = "";
  String passwordText = "";



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVerCode();
  }


  void getVerCode() async{
    code_value = getVerify(6);
    var result = await HttpRequest.request(HttpConfig.getCode, method: "get", params: {"code_value": code_value});
    verCodeImageBytes.value = result;
  }

  String getVerify(int length) {
    String code = "";
    String str = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    List strList = str.split("");
    for(int i = 0; i < length; i++) {
      Random random = Random.secure();
      code += strList[random.nextInt(str.length)];
    }
    return code;
  }

  showPassword() {
    psdObscure.value = !psdObscure.value;
  }

  clickSavePasswordBtn() {
    savePassword.value = !savePassword.value;
  }

  inputAccountValue(String account) {
    accountText = account;
    checkCanLogin();
  }
  inputPasswordValue(String password) {
    passwordText = password;
    checkCanLogin();
  }

  inputVerCodeValue(String code) {
    verCodeText = code;
    checkCanLogin();
  }

  void checkCanLogin() {
    if(accountText.isEmpty || passwordText.isEmpty || verCodeText.isEmpty) {
      canLogin.value = false;
    }else {
      canLogin.value = true;
    }
  }

  clickLoginBtn() async{
    Map<String, dynamic> params = {
      "username": accountText,
      "password": passwordText,
      "code": verCodeText,
      "code_value": code_value,
    };

    var result = await HttpRequest.request(
        HttpConfig.login, method: "post", params: params);
    if (result["code"] == 200) {
      ShowToast.showToast("登录成功");
      globalController.isLogin.value = true;
      SqliteUtil().setString(CacheKey.apiToken, result["data"]["token"]);
      SqliteUtil().setString(CacheKey.accountKey, accountText);
      if(savePassword.value) {
        SqliteUtil().setString(CacheKey.passwordKey, passwordText);
      }
      RouteUtil.popView();
    } else {
      ShowToast.showToast(result["message"]);
    }

  }

}