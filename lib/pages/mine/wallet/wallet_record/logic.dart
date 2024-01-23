import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/api/account_api.dart';
import '../../../../common/models/mine_wallet/user_money_details_model.dart';
import '../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import 'state.dart';
import 'package:intl/intl.dart';

class WalletRecordLogic extends GetxController {
  late PageController pageController = PageController(initialPage: 0);
  var currentIndex  = 0;
  UserMoneyDetailsModel? userMoneyDetailsModel;
  final WalletRecordWithdrawState userWithdrawState = WalletRecordWithdrawState();
  final WalletRecordRechargeState userRechargeState = WalletRecordRechargeState();
  String? dateType = "today";
  DateTime? startDate;
  DateTime? endDate;

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
  // 日期切换
  onTapSwitchDate(String dateType) async {
    this.dateType = dateType;
    this.startDate = null;
    this.endDate = null;
    update(['withdrawDateSelector']);
    update(['rechargeDateSelector']);

    await onRefresh();
  }

  switchDate(DateTime startDate, DateTime endDate) async {
    this.dateType = null;
    this.startDate = startDate;
    this.endDate = endDate;
    update(['withdrawDateSelector']);
    update(['rechargeDateSelector']);

    await onRefresh();
  }

  switchIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    update(["menu"]);
    initData();
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
      else {
        userWithdrawState.refreshController.finishLoad();
      }
    }
    else {
      userRechargeState.refreshController.finishRefresh();
      userRechargeState.refreshController.resetFooter();
      if (userRechargeState.isNoMoreData) {
        userRechargeState.refreshController.finishLoad(IndicatorResult.noMore);
      }
      else {
        userRechargeState.refreshController.finishLoad();
      }
    }
  }

  void onLoading() async{
    if (currentIndex == 0) {
      await fetchUserWithdrawList(false);
      userWithdrawState.refreshController.finishRefresh();
      if (userWithdrawState.isNoMoreData) {
        userWithdrawState.refreshController.finishLoad(IndicatorResult.noMore);
      }
      else {
        userWithdrawState.refreshController.finishLoad();
      }
    }
    else {
      await fetchUserRechargeList(false);
      userRechargeState.refreshController.finishRefresh();
      if (userRechargeState.isNoMoreData) {
        userRechargeState.refreshController.finishLoad(IndicatorResult.noMore);
      }
      else {
        userRechargeState.refreshController.finishLoad();
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
    String dateRange;
    if (this.startDate != null && this.endDate != null) {
      var startText = DateFormat('yyyy-MM-dd').format(this.startDate!);
      var endText = DateFormat('yyyy-MM-dd').format(this.endDate!);
      dateRange = startText + " - " + endText;
    }
    else {
      dateRange = this.dateType ?? "";
    }
    UserWithdrawListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserWithdrawList(dateRange, this.userWithdrawState.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userWithdrawState.userWithdrawModels = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userWithdrawState.userWithdrawModels.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      this.userWithdrawState.isNoMoreData = (userMoneyDetailsSearchListModel.total ?? 0) <= this.userWithdrawState.userWithdrawModels.length;
      update(["withdrawPage"]);
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
    String dateRange;
    if (this.startDate != null && this.endDate != null) {
      var startText = DateFormat('yyyy-MM-dd').format(this.startDate!);
      var endText = DateFormat('yyyy-MM-dd').format(this.endDate!);
      dateRange = startText + " - " + endText;
    }
    else {
      dateRange = this.dateType ?? "";
    }
    UserRechargeListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserRechargeList(dateRange, this.userRechargeState.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userRechargeState.userRechargeModels = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userRechargeState.userRechargeModels.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      this.userRechargeState.isNoMoreData = (userMoneyDetailsSearchListModel.total ?? 0) <= this.userRechargeState.userRechargeModels.length;
      update([ "chargePage"]);
    }
    return;
  }
}
