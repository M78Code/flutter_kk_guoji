
import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

import 'logic.dart';

class DetailLogic extends GetxController {

  final controller = Get.find<KKRebateLogic>();

  final detailList = [].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetail(controller.selectedRecordInfo.value);
  }

  getDetail(Map map) async{
    Map<String, dynamic> params = {
      "page":1,
      "limit":30,
      "game_type": map["game_type"],
      "receive_time":map["receive_time"],
      "create_time":map["create_time"]
    };

    var result = await HttpRequest.request(HttpConfig.getRecordDetail, params: params);
    print(result);
    if (result["code"] == 200) {
      detailList.value = result["data"]["list"];
    }
  }

}