import 'package:get/get.dart';

import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../common/api/agent_api.dart';
import '../promotion/model/promotion_model.dart';

class MineLogic extends GetxController {
  final userService = Get.find<UserService>();
  // UserInfoModel? userInfoModel; //用户信息类
  RxString portraitUrl = "".obs;
  RxBool isHiddenBalance =
  (SqliteService.to.getBool(CacheKey.balanceHidden) ?? true).obs; //默认是隐藏
  bool isSharePopViewVisible = false;
  KKPromotionModel? promotionModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     // userInfoModel = userService.userInfoModel.value;
     // portraitUrl = userInfoModel?.portrait?.obs ?? "".obs;


  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("onReady");
    super.onReady();

    fetchAgentTeam();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print("onClose");
    super.onClose();
  }

  toggleHiddenBalance() {
    isHiddenBalance.value = !isHiddenBalance.value;
    SqliteService.to.setBool(CacheKey.balanceHidden, isHiddenBalance.value);
    update(['balance']);
  }

  fetchAgentTeam() async {
    if(SqliteService.to.getString(CacheKey.apiToken) == null){
      return;
    }
    promotionModel = await AgentApi.getAgentTeam();
  }

  setIsSharePopViewVisible(bool isSharePopViewVisible) {
    this.isSharePopViewVisible = isSharePopViewVisible;
    update(["MinePage"]);
  }
}
