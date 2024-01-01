import 'package:get/get.dart';

import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../routes/routes.dart';
import '../../utils/route_util.dart';


class MineLogic extends GetxController {
  final userService = Get.find<UserService>();
  UserInfoModel? userInfoModel;//用户信息类
  bool isHiddenBalance = SqliteService.to.getBool(CacheKey.balanceHidden) ?? false;

  @override
  void onInit() {
    // TODO: implement onInit
    userInfoModel = userService.userInfoModel.value;
    super.onInit();
  }

  toggleHiddenBalance() {
    isHiddenBalance = !isHiddenBalance;
    SqliteService.to.setBool(CacheKey.balanceHidden, isHiddenBalance);
    update(['balance']);
  }
}
