import 'package:get/get.dart';

import '../common/api/account_api.dart';
import '../common/models/user_money_model.dart';


class UserService extends GetxService {
  static UserService get to => Get.find();

  // 是否登录
  final RxBool _isLogin = false.obs;
  set isLogin(value) => this._isLogin.value = value;
  bool get isLogin => this._isLogin.value;

  // 用户余额
  Rx<UserMoneyModel?> _userMoneyModel = Rx<UserMoneyModel?>(null);
  UserMoneyModel? get userMoneyModel => this._userMoneyModel.value;

  @override
  void onInit() {
    super.onInit();

  }

  fetchUserMoney() async {
    UserMoneyModel? userMoney = await AccountApi.getUserMoney();
    _userMoneyModel.value = userMoney;
  }

}