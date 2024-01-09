
import 'dart:ffi';
import 'dart:math';

import 'package:get/get.dart';
import 'package:kkguoji/pages/account/register/session.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../services/user_service.dart';
import '../../main/logic/main_logic.dart';

class RegisterLogic extends GetxController {


  final RxBool isAccount = true.obs;
  final RxBool isAgree = false.obs;
  final RxBool isCanRegister = false.obs;
  final RxBool psdObscure = true.obs;
  final RxBool verPsdObscure = true.obs;
  final RxList<int> verCodeImageBytes = RxList<int>();
  final sqliteService = Get.find<SqliteService>();
  final globalController = Get.find<UserService>();


  String accountText = "";
  String passwordText = "";
  String verPsdText = "";
  String inviteText = "";
  String verCodeText = "";

  int registerType = 1;
  String code_value = "";
  final isNeedVerCode = true.obs;
  final isShowInvite = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPublicInit();
  }

  void getPublicInit() async{
    var result = await HttpRequest.request(HttpConfig.publicInit);
    print(result);
    Map map = result["data"]["config"];
    isShowInvite.value = map["invite_register"].toString() == "0";
    isNeedVerCode.value = map["login_verification_code"].toString() == "0";
    if(isNeedVerCode.value) {
      getVerCode();
    }

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
        sqliteService.setString(CacheKey.apiToken, result["data"]["token"]);
        globalController.isLogin = true;
        globalController.fetchUserMoney();
        globalController.fetchUserInfo();
        sqliteService.setString(CacheKey.accountKey, accountText);
        sqliteService.setString(CacheKey.passwordKey, passwordText);
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
        globalController.isLogin = true;
        globalController.fetchUserMoney();
        globalController.fetchUserInfo();
        sqliteService.setString(CacheKey.apiToken, result["data"]["token"]);
        Get.find<MainPageLogic>().currentIndex.value = 0;
      } else {
        ShowToast.showToast(result["message"]);
      }
    }

}


void loginWithTg()  async{
  Get.toNamed(Routes.tgWebView);
  // RouteUtil.pushToView(Routes.webView, arguments:"https://testh502.759pc.com/pages/tg-auth/tg-auth" );
}

 Future<bool> registerWithTg(Map tgInfo, String tgStr) async{
    Map<String, dynamic> params = {"username":tgInfo["id"]??"",
     "user_nick":tgInfo["first_name"]??"" + " " +tgInfo["last_name"]??"",
      "portrait":tgInfo["photo_url"]??"",
      "way":"8","third_info":tgStr
    };
    var result = await HttpRequest.request(
        HttpConfig.register_third, method: "post", params: params);
    if (result["code"] == 200) {
      sqliteService.setString(CacheKey.apiToken, result["data"]["token"]);
      globalController.isLogin = true;
      globalController.fetchUserMoney();
      globalController.fetchUserInfo();
      sqliteService.setString(CacheKey.accountKey, accountText);
      sqliteService.setString(CacheKey.passwordKey, passwordText);
      return true;
      // SqliteUtil().setString(CacheKey.apiToken, result["data"]["token"]);
    } else {
      ShowToast.showToast(result["message"]);
      return false;
    }
  }


}