import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';

import '../../services/sqlite_service.dart';

class MineLogic extends GetxController {
  final userService = Get.find<UserService>();
  final mainController = Get.find<MainPageLogic>();

  UserInfoModel? userInfoModel;//用户信息类

  @override
  void onInit() {
    // TODO: implement onInit
    userInfoModel = userService.userInfoModel.value;
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
  }


  void clickLogout() {
    userService.isLogin = false;
    Get.find<SqliteService>().remove(CacheKey.apiToken);
    mainController.currentIndex.value = 0;
    userService.userInfoModel.value = null;
    userService.userMoneyModel = null;

  }
}
