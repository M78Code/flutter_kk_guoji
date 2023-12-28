
import 'package:get/get.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/config.dart';

class CustomerLogic extends GetxController {

  final customerMap = {}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCustomer();
  }

  void getCustomer() async{

    var result = await HttpRequest.request(HttpConfig.getCustomer);
    if(result["code"] == 200) {
      customerMap.value = result["data"];
    }

  }

  Future<void> telegramLaunch() async {
    if (!await launchUrl(Uri.parse(customerMap.value["site_telegram_url"]), mode: LaunchMode.externalApplication,)) {
      throw 'Could not launch Telegram';
    }
  }

}
