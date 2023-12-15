import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';

class MineLogic extends GetxController {
  final userService = Get.find<UserService>();

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
}
