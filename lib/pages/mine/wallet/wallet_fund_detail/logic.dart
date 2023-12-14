import 'dart:ffi';

import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';

import '../../../../common/models/mine_wallet/user_money_details_model.dart';

class WalletFundDetailLogic extends GetxController {

  var isWithdrawCheck = true;
  UserMoneyDetailsModel? userMoneyDetailsModel;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchUserMoneyDetails();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  onTapSwitchBar(bool isWithdrawCheck) {
    this.isWithdrawCheck = isWithdrawCheck ;
  }

  fetchUserMoneyDetails() async {
    UserMoneyDetailsModel? groupGameListModel = await AccountApi.getUserMoneyDetails();
    if (groupGameListModel != null) {
      userMoneyDetailsModel = groupGameListModel;
      update(["userMoneyDetails"]);
    }
  }

}
