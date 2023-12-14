import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class WalletRecordLogic extends GetxController {
  final WalletRecordPageState state = WalletRecordPageState();
  late PageController pageController = PageController(initialPage: 0);
  var currentIndex  = 0;
  String test = "test";
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  menuOntap(int toIndex) {
    // currentIndex = index;
    // update(["menu"]);
    pageController.jumpToPage(
        toIndex
    );
  }

  switchIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    update(["menu"]);
  }

}
