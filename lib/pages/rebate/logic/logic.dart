import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:kkguoji/pages/rebate/model/auto_record_model.dart';
import 'package:kkguoji/pages/rebate/model/record_rate_model.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../services/http_service.dart';
import '../../../services/config.dart';

class KKRebateLogic extends GetxController {
  //返回类型;
  final rebateType = 0.obs;

  //体育类型
  final ratioType = 0.obs;

  //日期选择
  final dateType = 0.obs;
  final autoRecordList = [].obs;
  final totalMoney = "".obs;
  final bannerList = [].obs;
  final gameList = [].obs;
  final dateList = ["today", "yesterday", "month", "last_month"];
  final dateTotalCount = 0.obs;
  final dateRecordList = [].obs;
  final recordRateList = [].obs;
  final gameIndex = 0.obs;
  final selectedDate = "".obs;

  final selectedRecordInfo = {}.obs;


  DateTime? startDate;
  DateTime? endDate;

  switchDate(DateTime startDate, DateTime endDate) async {
    this.dateType.value = 5;
    this.startDate = startDate;
    this.endDate = endDate;
      var startText = DateFormat('MM/dd').format(startDate);
      var endText = DateFormat('MM/dd').format(endDate);
      selectedDate.value = startText + " - " + endText;

    var startYearText = DateFormat('yyyy-MM-dd').format(startDate!);
    var endYearText = DateFormat('yyyy-MM-dd').format(endDate!);
    String dateRange = startYearText + "-" + endYearText;
    getRecord(dateRange);
  }

  changeRebateType(int index) {
    rebateType.value = index;
    if (index == 1) {
      changeDateType(0);
    } else if (index == 2) {
      getRatio(0);
    }
  }

  changeDateType(int index) {
    dateType.value = index;
    selectedDate.value = "";
    getRecord(dateList[index]);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanner();
    getGameTypeList();
    getAutoRecord();
    getTotalMoney();
  }

  void getBanner() async {
    Map<String, dynamic> bannerParms = {"position": "rabate_banner"};
    var bannerResult = await HttpRequest.request(HttpConfig.getBannerList, params: bannerParms);
    if (bannerResult["code"] == 200) {
      bannerList.value = bannerResult["data"];
    }
  }

  void getGameTypeList() async {
    var result = await HttpRequest.request(HttpConfig.getGameTypeList, method: "post");
    if (result["code"] == 200) {
      List gameInfos = result["data"];
      getRatio(gameInfos.first["id"]);
      gameList.value = result["data"];
    }
  }




  void getAutoRecord() async {
    List modelList = [];
    var result = await HttpRequest.request(HttpConfig.getAutoRecord);
    if (result["code"] == 200) {
      List list = result["data"];
      if (list.isNotEmpty) {
        list.forEach((element) {
          modelList.add(KKAutoRecordModel.fromJson(element));
        });
      }
    }
    autoRecordList.value = modelList;
  }

  void getTotalMoney() async {
    var result = await HttpRequest.request(HttpConfig.getTotalMoney);
    if (result["code"] == 200) {
      totalMoney.value = result["data"]["total_money"];
    }
  }

  void getRecord(String dateStr) async {
    var result = await HttpRequest.request(HttpConfig.getRecord, params: {"page": 1, "limit": 30, "time_range": dateStr});
    if (result["code"] == 200) {
      Map map = result["data"];
      dateTotalCount.value = map["totalCount"];
      dateRecordList.value = map["list"];
    }
  }

  void getRatio(int gameType) async {
    List modelList = [];
    var result = await HttpRequest.request(HttpConfig.getRatio, params: {"page": 1, "limit": 30, "game_type": gameType});
    if (result["code"] == 200) {
      List list = result["data"]["list"];
      if (list.isNotEmpty) {
        list.forEach((element) {
          modelList.add(KKRecordRateModel.fromJson(element));
        });
        recordRateList.value = modelList;
      }
    }
  }

  void clickGameBtn(int index) {
    if (index == 0) {
      getRatio(0);
    } else {}
  }

  void receiveRebate() async{
    if(double.parse(totalMoney.value) <= 0.0) {
      ShowToast.showToast("当前无可领取洗码金额");
      return;
    }
    var result = await HttpRequest.request(HttpConfig.receiveRebate, method: "post");
    if (result["code"] == 200) {
      ShowToast.showToast("领取成功");
      getTotalMoney();
    }else {
      ShowToast.showToast(result["data"]["message"]);
    }
  }
}
