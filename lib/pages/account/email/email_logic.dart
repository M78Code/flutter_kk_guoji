import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/widget/show_toast.dart';

///邮箱控制器
class EmailLogic extends GetxController {

  final userService = Get.find<UserService>();

  ///邮箱输入
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Timer? _timer;
  var countdown = 0.obs;
  String _bindValueCode = "";

  void sendCodeToEmail() async {
    if (!emailController.text.isEmail) {
      ShowToast.showToast("请输入邮箱账号");
      return;
    }
    _bindValueCode = getVerify(16);
    Map<String, dynamic> params = {"email": emailController.text, "code_value": _bindValueCode, "type": 2};
    var result = await HttpRequest.request(HttpConfig.sendCodeToEmail, method: "post", params: params);
    if (result["code"] == 200) {
      ShowToast.showToast("验证码发送成功");
      _startCountdown();
    } else {
      ShowToast.showToast(result["message"]);
    }
  }

  ///倒计时
  void _startCountdown() {
    countdown.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer?.cancel();
      }
    });
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

  ///邮箱绑定
  void bindEmail() async {
    if (!emailController.text.isEmail) {
      ShowToast.showToast("请输入邮箱账号");
      return;
    }
    if (codeController.text.isEmpty) {
      ShowToast.showToast("请输入邮箱验证码");
      return;
    }
    Map<String, dynamic> params = {"email": emailController.text, "code_value": _bindValueCode, "code": codeController.text};
    var result = await HttpRequest.request(HttpConfig.bindEmail, method: "get", params: params);
    if (result["code"] == 200) {
      ShowToast.showToast("绑定成功");
    } else {
      ShowToast.showToast(result["message"]);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }
}
