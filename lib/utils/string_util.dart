import 'package:get/get.dart';

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

  ///正则验证邮箱格式
  // static bool isEmail(String text) {
  //   if (text.isEmail || !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(text)) {
  //     return true;
  //   }
  //   return false;
  // }
}
