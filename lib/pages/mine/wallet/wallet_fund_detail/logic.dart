import 'dart:ffi';

import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';

import '../../../../common/models/mine_wallet/user_money_details_model.dart';
import '../../../../common/models/mine_wallet/user_money_details_search_respond_model.dart';

class WalletFundDetailLogic extends GetxController {

  var isWithdrawCheck = true;
  UserMoneyDetailsModel? userMoneyDetailsModel;
  List<UserMoneyDetailsSearchModel> userMoneyDetailsSearchList = [];
  final List<List<String>> dateTypes = [["today","今天"], ["yesterday","昨天" ], ["month","本月"], ["last_month","上月"],];
  var dateType = "today";
  int page = 1;
 
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchUserMoneyDetails();
    getUserMoneyDetailsSearch(true);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  onTapSwitchBar(bool isWithdrawCheck) {
    this.isWithdrawCheck = isWithdrawCheck ;
  }
  // 资产明细日期切换
  onTapSwitchFundDetailDate(String dateType) {
    this.dateType = dateType;
    update(['dateSelector']);
    getUserMoneyDetailsSearch(true);
  }
  fetchUserMoneyDetails() async {
    UserMoneyDetailsModel? userMoneyDetailsModel = await AccountApi.getUserMoneyDetails();
    if (userMoneyDetailsModel != null) {
      this.userMoneyDetailsModel = userMoneyDetailsModel;
      update(["userMoneyDetails"]);
    }
  }
  getUserMoneyDetailsSearch(bool isrefresh) async {
    if (isrefresh) {
      page = 1;
    }
    else {
      ++page;
    }
    UserMoneyDetailsSearchListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserMoneyDetailsSearch(dateType, this.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userMoneyDetailsSearchList = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userMoneyDetailsSearchList.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      update(["searchList"]);
    }
  }
}
