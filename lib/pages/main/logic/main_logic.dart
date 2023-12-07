

import 'package:get/get.dart';

class MainPageLogic {
  RxInt currentIndex = 0.obs;

  void clickTabBarItem(int index) {
    currentIndex.value = index;
  }
}