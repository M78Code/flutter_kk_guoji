import 'package:get/get.dart';

import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';

class MineLogic extends GetxController {
  final userService = Get.find<UserService>();
  UserInfoModel? userInfoModel; //用户信息类
  RxString portraitUrl = "".obs;
  bool isHiddenBalance = SqliteService.to.getBool(CacheKey.balanceHidden) ?? false;

  @override
  void onInit() {
    // TODO: implement onInit
    userInfoModel = userService.userInfoModel.value;
    portraitUrl = userInfoModel?.portrait?.obs ?? "".obs;
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("onReady");
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("onClose");
    super.onClose();
  }

  toggleHiddenBalance() {
    isHiddenBalance = !isHiddenBalance;
    SqliteService.to.setBool(CacheKey.balanceHidden, isHiddenBalance);
    update(['balance']);
  }
}
