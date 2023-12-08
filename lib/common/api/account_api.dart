import 'package:kkguoji/common/models/user_money_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class AccountApi {
  /// 分类列表
  static Future<UserMoneyModel?> getUserMoney() async {
    var result = await HttpRequest.request(HttpConfig.getUserMoney,params: {"is_mobile":"1"});
    if (result["code"] == 200) {
      UserMoneyModel? model = UserMoneyModel.fromJson(result['data']);
      return model;
    }
    return null;
  }
}