import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/services/user_service.dart';

class MineLogic extends GetxController {
  final userService = Get.find<UserService>();

  UserInfoModel? userInfoModel;//用户信息类

  @override
  void onReady() {
    // TODO: implement onReady
    userInfoModel = userService.userInfoModel.value;
    super.onReady();
  }
}
