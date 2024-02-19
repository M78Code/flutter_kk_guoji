
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/register/session.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/show_toast.dart';
import 'package:soundpool/soundpool.dart';

import '../../../services/user_service.dart';
import '../../../utils/websocket_util.dart';
import '../../main/logic/main_logic.dart';

class RegisterLogic extends GetxController {


  final RxBool isAccount = true.obs;
  final RxBool isAgree = false.obs;
  final RxBool isCanRegister = false.obs;
  final RxBool psdObscure = true.obs;
  final RxBool verPsdObscure = true.obs;
  final accountErrStr = "".obs;

  final passwordErrStr = "".obs;
  final psdLetter = false.obs;
  final psdNum = false.obs;
  final psdLength = false.obs;
  final psdSys = false.obs;
  final isHiddenPsdHit = true.obs;

  final verPsdErrStr = "".obs;

  final verCodeErrStr = "".obs;


  final RxnBool accountOK = RxnBool();
  final RxnBool psdOK = RxnBool();
  final RxnBool verPsdOK = RxnBool();
  final RxnBool verCodeOK = RxnBool();

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
  final isHiddenVerCode = true.obs;
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
    isHiddenVerCode.value = map["login_verification_code"].toString() == "0";
    if(!isHiddenVerCode.value) {
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
    if(accountText.isEmpty || passwordText.isEmpty || verPsdText.isEmpty) {
      isCanRegister.value = false;
    }else {
      if(isHiddenVerCode.value) {
        isCanRegister.value = true;
      }else {
        if(verCodeText.isEmpty) {
          isCanRegister.value = true;
        }else {
          isCanRegister.value = false;
        }

      }
    }
  }

  inputAccountValue(String account) {
    accountText = account;
    RegExp regExp = RegExp("^[A-Za-z][A-Za-z0-9]+\$");
    if(account.isEmpty) {
      accountErrStr.value = "用户名不能为空";
      accountOK.value = false;
    }else if(accountText.length< 4 || accountText.length > 12) {
      accountErrStr.value = "用户名长度为4-12位";
      accountOK.value = false;
    }else if (!regExp.hasMatch(account)) {
      accountErrStr.value = "用户名格式为首字母+数字的组合";
      accountOK.value = false;
    }else {
      accountErrStr.value = '';
      accountOK.value = true;
    }
    checkCanRegister();
  }
  inputPasswordValue(String password) {
    passwordText = password;
    if(passwordText.isEmpty) {
      isHiddenPsdHit.value = true;
      passwordErrStr.value = "密码不能为空";
      if(verPsdText.isEmpty) {
        verPsdErrStr.value = "密码不能为空";
      }else {
        verPsdErrStr.value = "两次输入的密码不一致";
      }
      psdOK.value = false;
      verPsdOK.value = false;
    }else {
      isHiddenPsdHit.value = false;
      psdLetter.value = RegExp("[a-zA-Z]").hasMatch(passwordText);
     psdLength.value = passwordText.length >= 8 && passwordText.length <= 12;
     psdNum.value = RegExp("[0-9]").hasMatch(passwordText);
     psdSys.value = RegExp("[~`!@#\$%^&*()+=|{}':;',\\[\\]<>/?.]").hasMatch(passwordText);
     if(psdLetter.value && psdNum.value && psdLength.value && psdSys.value) {
       psdOK.value = true;
     }else {
       psdOK.value = false;
     }

     if(verPsdText.isEmpty) {
       verPsdErrStr.value = "密码不能为空";
       verPsdOK.value = false;
     }else {
       if(passwordText != verPsdText) {
         verPsdErrStr.value = "两次输入的密码不一致";
         verPsdOK.value = false;
       }else {
         verPsdErrStr.value = "";
         verPsdOK.value = true;
       }
     }
    }
    checkCanRegister();
  }
  passwordLastInput(String password) {
    passwordText = password;
    if(passwordText.isEmpty) {
      isHiddenPsdHit.value = true;
      passwordErrStr.value = "密码不能为空";
      psdOK.value = false;
    }
  }

  verPasswordLastInput(String password) {
    verPsdText = password;
    if(passwordText.isEmpty) {
      verPsdErrStr.value = "密码不能为空";
      verPsdOK.value = false;
    }

  }
  inputVerPasswordValue(String verPsd) {
    verPsdText = verPsd;
    if(verPsdText.isEmpty) {
      verPsdErrStr.value = "密码不能为空";
      verPsdOK.value = false;
    }else {
      if(passwordText != verPsdText) {
        verPsdErrStr.value = "两次输入的密码不一致";
        verPsdOK.value = false;
      }else {
        verPsdErrStr.value = "";
        verPsdOK.value = true;
      }
    }
    checkCanRegister();
  }
  inputInviteCodeValue(String code) {
    inviteText = code;

    checkCanRegister();
  }
  inputVerCodeValue(String code) {
    verCodeText = code;
    if(verCodeText.isEmpty) {
      verCodeErrStr.value = "验证码不能为空";
      verCodeOK.value = false;
    }else if(verCodeText.length != 4) {
      verCodeErrStr.value = "验证码长度为4位!";
      verCodeOK.value = false;
    }else {
      verCodeErrStr.value = "";
      verCodeOK.value = true;
    }
    if(!isHiddenVerCode.value) {
      checkCanRegister();
    }
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
    if(isAgree.value == false) {
      ShowToast.showToast("请阅读并同意相关条款");
      return;
    }
    if(isAccount.value) {
      Map<String, dynamic> params = {
        "username": accountText,
        "password": passwordText,
        "invite_code":inviteText
      };
      if(!isHiddenVerCode.value) {
        params["code"] = verCodeText;
        params["code_value"] = code_value;
      }


      var result = await HttpRequest.request(
          HttpConfig.registerByAccount, method: "post", params: params);
      if (result["code"] == 200) {
        ShowToast.showToast("注册成功");
        playSound();
        sqliteService.setString(CacheKey.apiToken, result["data"]["token"]);
        globalController.isLogin = true;
        globalController.fetchUserMoney();
        globalController.fetchUserInfo();
        WebSocketUtil().connetSocket();
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
        WebSocketUtil().connetSocket();
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
      WebSocketUtil().connetSocket();
      sqliteService.setString(CacheKey.accountKey, accountText);
      sqliteService.setString(CacheKey.passwordKey, passwordText);
      return true;
      // SqliteUtil().setString(CacheKey.apiToken, result["data"]["token"]);
    } else {
      ShowToast.showToast(result["message"]);
      return false;
    }
  }


  void playSound() async {
    Soundpool  soundpool = Soundpool(streamType: StreamType.notification);
    int soundId = await rootBundle.load("assets/audios/welcome.mp3").then((ByteData data){
      return soundpool.load(data);
    });
    // soundpool.setVolume(volume: 1.0);
    await soundpool.play(soundId);
  }

}