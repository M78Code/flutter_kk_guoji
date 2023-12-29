import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kkguoji/widget/show_toast.dart';
import 'package:path_provider/path_provider.dart';

class StringUtil {
  StringUtil._();

  /// number传入的值
  /// position保留几位小数
  /// 不进行四舍五入
  static String formatNum(dynamic number, int position) {
    double num;
    if (number is double) {
      num = number;
    } else {
      num = double.parse(number.toString());
    }
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < position) {
      return num.toStringAsFixed(position).substring(0, num.toString().lastIndexOf(".") + position + 1).toString();
    } else {
      return num.toString().substring(0, num.toString().lastIndexOf(".") + position + 1).toString();
    }
  }

  static bool checkPsdRule(String psd) {
    // 密码规则：包含数字、字母、特殊字符，长度在8～20位之间
    RegExp regex = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$%^&*()_+{}|:"<>?]).{8,20}$');
    // RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{8,20}$');
    // RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)(?![a-zA-Z0-9]+$)[a-zA-Z0-9\S]{8,20}$');
    return regex.hasMatch(psd);
  }

  static void clipText(String? text) {
    Clipboard.setData(ClipboardData(text: text ?? "")).then((value) => ShowToast.showToast("复制成功"));
  }

  ///获取应用程序目录文件
  static Future<File> getLocalSupportFile(String path) async {
    final dir = await getApplicationDocumentsDirectory();

    print("dir = ${dir.path}");
    return File('${dir.path}/$path');
  }


  // static Future<File> getAbsolutePath() async{
  //   final flutterAbsolutePath = await FlutterAbsolutePath
  // }

  ///正则验证邮箱格式
// static bool isEmail(String text) {
//   if (text.isEmail || !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(text)) {
//     return true;
//   }
//   return false;
// }
}
