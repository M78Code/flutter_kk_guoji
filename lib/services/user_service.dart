import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';

import '../common/api/account_api.dart';
import '../common/models/user_money_model.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

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

  fetchUserMoney() async {
    UserMoneyModel? userMoney = await AccountApi.getUserMoney();
    _userMoneyModel.value = userMoney;
  }

  fetchUserInfo() async {
    UserInfoModel? userInfo = await AccountApi.getUserInfo();
    userInfoModel.value = userInfo;
    isBindEmail = null != userInfo?.email;
  }
}
