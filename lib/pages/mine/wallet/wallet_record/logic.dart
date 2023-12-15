import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/api/account_api.dart';
import '../../../../common/models/mine_wallet/user_money_details_model.dart';
import '../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import 'state.dart';


class UserWithdrawState {
  List<UserWithdrawModel> userWithdrawModels = [];
  final List<List<String>> dateTypes = [["today","今天"], ["yesterday","昨天" ], ["month","本月"], ["last_month","上月"],];
  var dateType = "today";
  int page = 1;
  bool isNoMoreData = false;
  EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  EasyRefreshController get refreshController => _refreshController;
}

class WalletRecordLogic extends GetxController {
  final WalletRecordPageState state = WalletRecordPageState();
  late PageController pageController = PageController(initialPage: 0);
  var currentIndex  = 0;
  UserMoneyDetailsModel? userMoneyDetailsModel;
  List<UserRechargeModel> userRechargeModels = [];
  UserWithdrawState userWithdrawState = UserWithdrawState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  menuOntap(int toIndex) {
    // currentIndex = index;
    // update(["menu"]);
    pageController.jumpToPage(
        toIndex
    );
  }
  // 资产明细日期切换
  onTapSwitchlDate(String dateType) async {
    userWithdrawState.dateType = dateType;
    update(['dateSelector']);
    // _refreshController.resetNoData();
    await onRefresh();
  }
  switchIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    update(["menu"]);
  }
  Future<void> onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await initData();
    // if failed,use refreshFailed()
    userWithdrawState.refreshController.finishRefresh();
    userWithdrawState.refreshController.resetFooter();
    if (userWithdrawState.isNoMoreData) {
      userWithdrawState.refreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  void onLoading() async{
    // monitor network fetch
    // await getUserMoneyDetailsSearch(false);
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    userWithdrawState.refreshController.finishRefresh();
    if (userWithdrawState.isNoMoreData) {
      userWithdrawState.refreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  initData() {
    fetchUserMoneyDetails();
    fetchUserWithdrawList(true);
  }

  fetchUserMoneyDetails() async {
    UserMoneyDetailsModel? userMoneyDetailsModel = await AccountApi.getUserMoneyDetails();
    if (userMoneyDetailsModel != null) {
      this.userMoneyDetailsModel = userMoneyDetailsModel;
      update(["userMoneyDetails"]);
    }
  }

  Future<void> fetchUserWithdrawList(bool isrefresh) async {
    if (isrefresh) {
      userWithdrawState.page = 1;
    }
    else {
      ++userWithdrawState.page;
    }
    UserWithdrawListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserWithdrawList(userWithdrawState.dateType, this.userWithdrawState.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userWithdrawState.userWithdrawModels = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userWithdrawState.userWithdrawModels.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      this.userWithdrawState.isNoMoreData = (userMoneyDetailsSearchListModel.total ?? 0) <= this.userWithdrawState.userWithdrawModels.length;
      update(["searchList"]);
    }
    return;
  }
}
