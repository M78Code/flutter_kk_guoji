
import 'dart:math';

import 'package:get/get.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_request.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

class RegisterLogic extends GetxController {


  final RxBool isAccount = true.obs;
  final RxBool isAgree = false.obs;
  final RxBool isCanRegister = false.obs;
  final RxBool psdObscure = true.obs;
  final RxBool verPsdObscure = true.obs;
  final RxList<int> verCodeImageBytes = RxList<int>();

  String accountText = "";
  String passwordText = "";
  String verPsdText = "";
  String inviteText = "";
  String verCodeText = "";

  int registerType = 1;
  String code_value = "";


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
    checkCanRegister();
  }

  showPassword() {
    psdObscure.value = !psdObscure.value;
  }

  showVerPassword() {
    verPsdObscure.value = !verPsdObscure.value;
  }

  checkCanRegister() {
    if(accountText.isEmpty || passwordText.isEmpty || verPsdText.isEmpty || isAgree.value == false) {
      isCanRegister.value = false;
    }else {
      isCanRegister.value = true;
    }
  }

  inputAccountValue(String account) {
    accountText = account;
    checkCanRegister();
  }
  inputPasswordValue(String password) {
    passwordText = password;
    checkCanRegister();
  }
  inputVerPasswordValue(String verPsd) {
    verPsdText = verPsd;
    checkCanRegister();
  }
  inputInviteCodeValue(String code) {
    inviteText = code;
    checkCanRegister();
  }
  inputVerCodeValue(String code) {
    verCodeText = code;
    checkCanRegister();
  }

  void sendCodeToEmail() async {
    Map<String, dynamic> params = {
      "email": accountText,
      "code_value": code_value,
      "type": 1
    };
    var result = await HttpRequest.request(HttpConfig.sendCodeToEmail, method: "post", params: params);
    if(result["code"] == 200) {
      ShowToast.showToast("验证码发送成功");
    }else {
      ShowToast.showToast(result["message"]);
    }
  }

  void clickRegisterBtn() async{
    if(!isCanRegister.value) {
      return;
    }
    if(isAccount.value) {
      Map<String, dynamic> params = {
        "username": accountText,
        "password": passwordText,
        "code": verCodeText,
        "code_value": code_value,
        "invite_code": inviteText
      };

      var result = await HttpRequest.request(
          HttpConfig.registerByAccount, method: "post", params: params);
      if (result["code"] == 200) {
        ShowToast.showToast("注册成功");
        SqliteUtil().setString(CacheKey.apiToken, result["data"]["token"]);
        RouteUtil.popView();
      } else {
        ShowToast.showToast(result["message"]);
      }
    }else {
      Map<String, dynamic> params = {
        "email": accountText,
        "password": passwordText,
        "code": verCodeText,
        "code_value": code_value,
        "invite_code": inviteText
      };

      var result = await HttpRequest.request(
          HttpConfig.registerByEmail, method: "post", params: params);
      if (result["code"] == 200) {
        ShowToast.showToast("注册成功");
        SqliteUtil().setString(CacheKey.apiToken, result["data"]["token"]);
      } else {
        ShowToast.showToast(result["message"]);
      }
    }

}


}