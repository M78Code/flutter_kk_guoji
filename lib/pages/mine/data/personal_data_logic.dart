import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class PersonalDataLogic extends GetxController {
  final dateType = 0.obs;
  final data = {}.obs;
  final gameList = [].obs;
  final dateList = ["today", "yesterday", "month", "last_month"];



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPersonalData(dateList[dateType.value]);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  changeDateType(int index) {
    dateType.value = index;
    getPersonalData(dateList[index]);
  }
  
  void getPersonalData(String dateStr) async{
    var result = await HttpRequest.request(HttpConfig.getGameDataStatistics, method:"post", params: {"time_range":dateStr});
    if(result["code"] == 200) {
      data.value = result["data"];
      gameList.value = result["data"]["game_details"];
    }
  }
}