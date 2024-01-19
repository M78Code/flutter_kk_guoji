import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static showToast(String string) {
    if (string == null || string.length == 0) { return; }
    showToast(string);
  }
}
