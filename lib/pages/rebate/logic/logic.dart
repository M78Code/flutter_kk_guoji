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
  final ticketMap = {}.obs;
  final dateList = ["today", "yesterday", "month", "last_month"];
  final dateTotalCount = 0.obs;
  final dateRecordList = [].obs;
  final recordRateList = [].obs;
  final gameIndex = 0.obs;
  final selectedDate = "".obs;

  final selectedRecordInfo = {}.obs;
  final isSelectedGames = true.obs;


  Map allTicketMap= {};
  final AllTickInfoMap = {}.obs;

  final allTicketKeyList = [].obs;
  final tickTypeStr = "全部".obs;



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
    gameIndex.value = 0;
    if (index == 1) {
      changeDateType(0);
    } else if (index == 2) {
      Map map = gameList.value.first;
      getRatio(map["id"]);
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
    getRatio(3);
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
      if(gameInfos.isNotEmpty) {
        getRatio(gameInfos.first["id"]);
        int index = gameInfos.indexWhere((element) {
          Map m = element as Map;
          return m["name"].toString().contains("彩票");
        });
        ticketMap.value = gameInfos[index];
        gameInfos.removeAt(index);
        gameList.value = gameInfos;
      }

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
      if(gameType != 3) {
        if (list.isNotEmpty) {
          list.forEach((element) {
            modelList.add(KKRecordRateModel.fromJson(element));
          });
          recordRateList.value = modelList;
        }else {
          recordRateList.value = [];
        }
      }else {
        if(list.isNotEmpty) {
          List gameRatioList = (list.first as Map)["list"];
          Map ticketMap = {};
          gameRatioList.forEach((element) {
            ticketMap[element["lotteryName"]] = element["play"];
          });
          allTicketMap = ticketMap;
          allTicketMap["全部"] = dealAllGameRatioList();
          List keys = ticketMap.keys.toList();
          keys.insert(0, "全部");
          allTicketKeyList.value = keys;
        }else {
          recordRateList.value = [];
        }
      }
    }
  }

  List dealAllGameRatioList() {
    List allList = [];
    allTicketMap.forEach((key, value) {
      List playList = value;
      playList.forEach((element) {
        element["playName"] = key + "(${element["playName"]})";
        allList.add(element);
      });
      print(playList);
    });
    return allList;
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

  void clickTicketType(String typeStr) {
    tickTypeStr.value = typeStr;
    Map map = Map.from(ticketMap.value);
    // Map map = ticketMap.value;
    if(typeStr != "全部") {
      map["name"] = "彩票-$typeStr";
    }else {
      map["name"] = "彩票";
    }
    ticketMap.value = map;
  }


}
