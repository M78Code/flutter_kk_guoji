import 'package:get/get.dart';
import '../../../services/http_service.dart';
import '../../../services/config.dart';

class KKRebateLogic extends GetxController {

  final rebateType = 0.obs;
  final ratioType = 0.obs;
  final dateType = 0.obs;

  changeRebateType(int index) {
    rebateType.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanner();
  }

  void getBanner() async{
  Map<String, dynamic> bannerParms = {"position": "rebate_banner"};
  var bannerResult = await HttpRequest.request(HttpConfig.getBannerList,
  params: bannerParms);
  if (bannerResult["code"] == 200) {

  }
}

}