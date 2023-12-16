import 'package:get/get.dart';

import 'package:kkguoji/pages/rebate/model/auto_record_model.dart';
import 'package:kkguoji/pages/rebate/model/record_rate_model.dart';

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

  changeRebateType(int index) {
    rebateType.value = index;

    if (index == 1) {
      getRecord(dateList.first);
    } else if (index == 2) {

      getRatio(0);
    }
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
    if (result["code"] == 200) {}
>>>>>>> leon
  }

  void getAutoRecord() async {
    List modelList = [];
    var result = await HttpRequest.request(HttpConfig.getAutoRecord);
<<<<<<< HEAD
    if(result["code"] == 200) {
       List list = result["data"];
       if(list.isNotEmpty) {
          list.forEach((element) {
            modelList.add(KKAutoRecordModel.fromJson(element));
          });
       }
=======
    if (result["code"] == 200) {
      List list = result["data"];
      if (list.isNotEmpty) {
        list.forEach((element) {
          modelList.add(KKAutoRecordModel.fromJson(element));
        });
      }
>>>>>>> leon
    }
    autoRecordList.value = modelList.obs;
  }

  void getTotalMoney() async {
    var result = await HttpRequest.request(HttpConfig.getTotalMoney);
<<<<<<< HEAD
    if(result["code"] == 200) {
     totalMoney.value = result["data"]["total_money"];

=======
    if (result["code"] == 200) {
      totalMoney.value = result["data"]["total_money"];
>>>>>>> leon
    }
  }

  void getRecord(String dateStr) async {
<<<<<<< HEAD
      var result = await HttpRequest.request(HttpConfig.getRecord, params: {"page":1, "limit":30, "time_range":dateStr});
      if(result["code"] == 200) {
        Map map = result["data"];
        dateTotalCount.value = map["totalCount"];
        dateRecordList.value = map["list"];
      }
  }

  void getRatio(int gameType) async {
    var result = await HttpRequest.request(HttpConfig.getRatio, params: {"page":1, "limit":30, "game_type":gameType});
    if(result["code"] == 200) {
      List list = result["data"]["list"];
      if(list.isNotEmpty) {
=======
    var result = await HttpRequest.request(HttpConfig.getRecord, params: {"page": 1, "limit": 30, "time_range": dateStr});
    if (result["code"] == 200) {
      Map map = result["data"];
      dateTotalCount.value = map["totalCount"];
      dateRecordList.value = map["list"];
    }
  }

  void getRatio(int gameType) async {
    var result = await HttpRequest.request(HttpConfig.getRatio, params: {"page": 1, "limit": 30, "game_type": gameType});
    if (result["code"] == 200) {
      List list = result["data"]["list"];
      if (list.isNotEmpty) {
>>>>>>> leon
        list.forEach((element) {
          recordRateList.add(KKRecordRateModel.fromJson(element));
        });
      }
    }
  }

  void clickGameBtn(int index) {
<<<<<<< HEAD
     if(index == 0) {
       getRatio(0);
     }else {

     }
  }

}
=======
    if (index == 0) {
      getRatio(0);
    } else {}
  }
}
>>>>>>> leon
