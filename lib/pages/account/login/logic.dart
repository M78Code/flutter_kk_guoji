import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'dart:math';

import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../services/sqlite_service.dart';
import '../../../utils/websocket_util.dart';

class LoginLogic extends GetxController {
  final RxBool psdObscure = true.obs;
  final RxBool savePassword = true.obs;
  final RxBool canLogin = false.obs;
  final passwordObs = "".obs;
  final accountObs = "".obs;

  final globalController = Get.find<UserService>();
  final sqliteService = Get.find<SqliteService>();

  final RxList<int> verCodeImageBytes = RxList<int>();
  final isHiddenVerCode = true.obs;
  final isShowInvite = true.obs;

  String code_value = "";
  String verCodeText = "";
  String accountText = "";
  String passwordText = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPublicInit();
    //
    accountText = sqliteService.getString(CacheKey.accountKey) ?? "";
    accountObs.value = accountText;
    passwordText = sqliteService.getString(CacheKey.passwordKey) ?? "";
    passwordObs.value = passwordText;
  }


  void getPublicInit() async{
    var result = await HttpRequest.request(HttpConfig.publicInit);
    print(result);
    Map map = result["data"]["config"];
    isHiddenVerCode.value = map["login_verification_code"].toString() == "0";
    if(!isHiddenVerCode.value) {
      getVerCode();
    }
    checkCanLogin();

  }

  void getVerCode() async {
    code_value = getVerify(6);
    var result = await HttpRequest.request(HttpConfig.getCode, method: "get", params: {"code_value": code_value});
    verCodeImageBytes.value = result;
  }

  String getVerify(int length) {
    String code = "";
    String str = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    List strList = str.split("");
    for (int i = 0; i < length; i++) {
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
    if(isHiddenVerCode.value) {
      checkCanLogin();
    }
  }

  void checkCanLogin() {
    if (accountText.isEmpty || passwordText.isEmpty) {
      canLogin.value = false;
    } else {
      if(isHiddenVerCode.value) {
        canLogin.value = true;
      }else {
        if(verCodeText.isEmpty) {
          canLogin.value = true;
        }else {
          canLogin.value = false;
        }

      }

    }
  }

  clickLoginBtn() async {
    Map<String, dynamic> params = {
      "username": accountText,
      "password": passwordText,
    };

    if(!isHiddenVerCode.value) {
      params["code"] = verCodeText;
      params["code_value"] = code_value;
    }

    var result = await HttpRequest.request(HttpConfig.login, method: "post", params: params);
    if (result["code"] == 200) {
      ShowToast.showToast("登录成功");
      globalController.isLogin = true;
      globalController.fetchUserMoney();
      globalController.fetchUserInfo();
      sqliteService.setString(CacheKey.apiToken, result["data"]["token"]);

      if (savePassword.value) {
        sqliteService.setString(CacheKey.accountKey, accountText);
        sqliteService.setString(CacheKey.passwordKey, passwordText);
      } else {
        sqliteService.remove(CacheKey.accountKey);
        sqliteService.remove(CacheKey.passwordKey);
      }
      WebSocketUtil().connetSocket();
      Get.find<MainPageLogic>().currentIndex.value = 0;
      RouteUtil.pushToView(Routes.mainPage, offAll: true);
      // RouteUtil.popView();
    } else {
      ShowToast.showToast(result["message"]);
    }
  }
}
