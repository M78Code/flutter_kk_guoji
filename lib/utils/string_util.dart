class StringUtil {
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
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        position) {
      return num.toStringAsFixed(position)
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + position + 1)
          .toString();
    }
  }
}
