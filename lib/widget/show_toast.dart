import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart' as OkToast ;

class ShowToast {
  static showToast(String string) {
    if (string == null || string.length == 0) { return; }
    OkToast.showToast(string);
  }
}
