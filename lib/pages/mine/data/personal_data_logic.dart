import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class PersonalDataLogic extends GetxController {
  final dateType = 0.obs;
  final data = {}.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPersonalData();
  }
  
  void getPersonalData() async{
    var result = await HttpRequest.request(HttpConfig.getGameDataStatistics, method:"post", params: {"time_range":"yesterday"});
    print(result);
    if(result["code"] == 200) {
      data.value = result["data"];
    }
  }
}