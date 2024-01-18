import 'dart:ffi';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';

import '../../../../common/models/mine_wallet/user_money_details_model.dart';
import '../../../../common/models/mine_wallet/user_money_details_search_respond_model.dart';
import 'package:intl/intl.dart';

class WalletFundDetailLogic extends GetxController {

  var isWithdrawCheck = true;
  UserMoneyDetailsModel? userMoneyDetailsModel;
  List<UserMoneyDetailsSearchModel> userMoneyDetailsSearchList = [];
  final List<List<String>> dateTypes = [["today","今天"], ["yesterday","昨天" ], ["month","本月"], ["last_month","上月"],];
  String? dateType = "today";
  DateTime? startDate;
  DateTime? endDate;
  int page = 1;
  bool isNoMoreData = false;
  EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  EasyRefreshController get refreshController => _refreshController;

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

  initData() {
    fetchUserMoneyDetails();
    getUserMoneyDetailsSearch(true);
  }
  onTapSwitchBar(bool isWithdrawCheck) {
    this.isWithdrawCheck = isWithdrawCheck ;
  }
  // 资产明细日期切换
  onTapSwitchDate(String dateType) async {
    this.dateType = dateType;
    this.startDate = null;
    this.endDate = null;
    update(['dateSelector']);
    await onRefresh();
  }

  switchDate(DateTime startDate, DateTime endDate) async {
    this.dateType = null;
    this.startDate = startDate;
    this.endDate = endDate;
    update(['dateSelector']);
    await onRefresh();
  }

  fetchUserMoneyDetails() async {
    UserMoneyDetailsModel? userMoneyDetailsModel = await AccountApi.getUserMoneyDetails();
    if (userMoneyDetailsModel != null) {
      this.userMoneyDetailsModel = userMoneyDetailsModel;
      update(["userMoneyDetails"]);
    }
  }

  Future<void> getUserMoneyDetailsSearch(bool isrefresh) async {
    if (isrefresh) {
      page = 1;
    }
    else {
      ++page;
    }
    String dateRange;
    if (startDate != null && endDate != null) {
      var startText = DateFormat('yyyy-MM-dd').format(startDate!);
      var endText = DateFormat('yyyy-MM-dd').format(endDate!);
      dateRange = startText + " - " + endText;
    }
    else {
      dateRange = dateType ?? "";
    }
    UserMoneyDetailsSearchListModel? userMoneyDetailsSearchListModel = await AccountApi.getUserMoneyDetailsSearch(dateRange, this.page, "");
    if (userMoneyDetailsSearchListModel != null) {
      if (isrefresh) {
        this.userMoneyDetailsSearchList = userMoneyDetailsSearchListModel.list ?? [];
      }
      else {
        this.userMoneyDetailsSearchList.addAll(userMoneyDetailsSearchListModel.list ?? []);
      }
      this.isNoMoreData = (userMoneyDetailsSearchListModel.totalCount ?? 0) <= this.userMoneyDetailsSearchList.length;
      update(["searchList", "searchListHeader"]);
    }
    return;
  }

  Future<void> onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await initData();
    // if failed,use refreshFailed()
    _refreshController.finishRefresh();
    _refreshController.resetFooter();
    if (this.isNoMoreData) {
      _refreshController.finishLoad(IndicatorResult.noMore);
    }
    else {
      _refreshController.finishLoad();
    }
  }

  void onLoading() async{
    // monitor network fetch
    await getUserMoneyDetailsSearch(false);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.finishRefresh();
    if (this.isNoMoreData) {
      _refreshController.finishLoad(IndicatorResult.noMore);
    }
    else {
      _refreshController.finishLoad();
    }
  }
}
