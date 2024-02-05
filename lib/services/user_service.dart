import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/sqlite_service.dart';

import '../common/api/account_api.dart';
import '../common/models/user_money_model.dart';
import '../pages/main/logic/main_logic.dart';
import '../utils/websocket_util.dart';
import 'cache_key.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  final RouteObserver<PageRoute> routeObserver= RouteObserver<PageRoute>();

  // 是否登录
  final RxBool _isLogin = false.obs;

  set isLogin(value) => this._isLogin.value = value;

  bool get isLogin => this._isLogin.value;

  //邮箱是否绑定
  bool isBindEmail = true;

  // 用户余额
  Rx<UserMoneyModel?> _userMoneyModel = Rx<UserMoneyModel?>(null);

  UserMoneyModel? get userMoneyModel => this._userMoneyModel.value;

  set userMoneyModel(value) => this._userMoneyModel.value = value;

  //用户信息
  Rx<UserInfoModel?> userInfoModel = Rx<UserInfoModel?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUserMoney() async {
    UserMoneyModel? userMoney = await AccountApi.getUserMoney();
    _userMoneyModel.value = userMoney;
  }

  Future<void> fetchUserInfo() async {
    UserInfoModel? userInfo = await AccountApi.getUserInfo();
    userInfoModel.value = userInfo;
    isBindEmail = null != userInfo?.email;
  }

  Future<UserInfoModel?> fetchUserInfoForInit() async {
    UserInfoModel? userInfo = await AccountApi.getUserInfo();
    return userInfo;
  }

  void logout() async {
    isLogin = false;
    Get.find<SqliteService>().remove(CacheKey.apiToken);
    WebSocketUtil().closeSocket();
    Get.find<MainPageLogic>().currentIndex.value = 0;
    userInfoModel.value = null;
    userMoneyModel = null;
  }
}
