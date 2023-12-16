import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/api/account_api.dart';
import '../../../../common/models/mine_wallet/user_money_details_model.dart';
import '../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import 'state.dart';




class WalletRecordLogic extends GetxController {
  late PageController pageController = PageController(initialPage: 0);
  var currentIndex  = 0;
  UserMoneyDetailsModel? userMoneyDetailsModel;
  final WalletRecordWithdrawState userWithdrawState = WalletRecordWithdrawState();
  final WalletRecordRechargeState userRechargeState = WalletRecordRechargeState();

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
    if (currentIndex == 0) {
      userWithdrawState.dateType = dateType;
      update(['withdrawDateSelector']);
    }
    else {
      userRechargeState.dateType = dateType;
      update(['rechargeDateSelector']);
    }

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
    if (currentIndex == 0) {
      userWithdrawState.refreshController.finishRefresh();
      userWithdrawState.refreshController.resetFooter();
      if (userWithdrawState.isNoMoreData) {
        userWithdrawState.refreshController.finishLoad(IndicatorResult.noMore);
      }
    }
    else {
      userRechargeState.refreshController.finishRefresh();
      userRechargeState.refreshController.resetFooter();
      if (userRechargeState.isNoMoreData) {
        userRechargeState.refreshController.finishLoad(IndicatorResult.noMore);
      }
    }
  }

  void onLoading() async{
    // monitor network fetch
    // await getUserMoneyDetailsSearch(false);
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (currentIndex == 0) {
      await fetchUserWithdrawList(false);
      userWithdrawState.refreshController.finishRefresh();
      if (userWithdrawState.isNoMoreData) {
        userWithdrawState.refreshController.finishLoad(IndicatorResult.noMore);
      }
    }
    else {
      await fetchUserRechargeList(false);
      userRechargeState.refreshController.finishRefresh();
      if (userRechargeState.isNoMoreData) {
        userRechargeState.refreshController.finishLoad(IndicatorResult.noMore);
      }
    }
  }

  initData() {
    fetchUserMoneyDetails();
    if (currentIndex == 0) {
      fetchUserWithdrawList(true);
    }
    else {
      fetchUserRechargeList(true);
    }
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
  Future<void> fetchUserRechargeList(bool isrefresh) async {
    if (isrefresh) {
      userRechargeState.page = 1;
    }
    else {
      ++userRechargeState.page;
    }
    UserRechargeListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserRechargeList(userRechargeState.dateType, this.userRechargeState.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userRechargeState.userRechargeModels = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userRechargeState.userRechargeModels.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      this.userRechargeState.isNoMoreData = (userMoneyDetailsSearchListModel.total ?? 0) <= this.userRechargeState.userRechargeModels.length;
      update(["searchList"]);
    }
    return;
  }
}
