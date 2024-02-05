

import 'package:get/get.dart';

import '../../../services/user_service.dart';

class MainPageLogic extends GetxController{
  RxInt currentIndex = 0.obs;
  final globalController = Get.find<UserService>();

  void clickTabBarItem(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    globalController.fetchUserInfo();
  }
}