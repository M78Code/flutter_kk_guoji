import 'dart:convert';

import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/common/models/user_money_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class AccountApi {

  static Future<UserMoneyModel?> getUserMoney() async {
    var result = await HttpRequest.request(HttpConfig.getUserMoney,params: {"is_mobile":"1"});
    if (result["code"] == 200) {
      UserMoneyModel? model = UserMoneyModel.fromJson(result['data']);
      return model;
    }
    return null;
  }

  static Future<UserInfoModel?> getUserInfo() async {
    var result = await HttpRequest.request(HttpConfig.getUserInfo);
    if(result["code"] == 200) {
      UserInfoModel? model = UserInfoModel.fromJson(result["data"]);
      return model;
    }
    return null;

  }
}