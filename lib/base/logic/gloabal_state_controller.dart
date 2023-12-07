import 'package:get/get.dart';
import 'package:kkguoji/utils/account_service.dart';

import '../../services/cache_key.dart';
import '../../utils/sqlite_util.dart';

class GlobalStateController extends GetxController {
  final isLogin = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(SqliteUtil().getString(CacheKey.apiToken) != null) {
      isLogin.value = true;
    }else {
      isLogin.value = false;
    }
  }
}