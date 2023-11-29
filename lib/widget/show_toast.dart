
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static showToast(String string) {
     Fluttertoast.showToast(msg: string,
         toastLength: Toast.LENGTH_SHORT,
       timeInSecForIosWeb: 1,

       backgroundColor: const Color.fromRGBO(108, 122, 143, 0.24),
       textColor: Colors.white,
       fontSize: 15.0
     );
  }
}