import 'dart:convert';
import 'dart:ffi';

import 'package:kkguoji/common/models/mine_wallet/user_money_details_model.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/common/models/user_money_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

import '../models/mine_wallet/user_money_details_search_respond_model.dart';

class AccountApi {

  static Future<UserMoneyModel?> getUserMoney() async {
    var result = await HttpRequest.request( HttpConfig.getUserMoney, method: "get", params: {"is_mobile":"1"});
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
  static Future<UserMoneyDetailsModel?> getUserMoneyDetails() async {
    var result = await HttpRequest.request(HttpConfig.getUserMoneyDetails);
    if(result["code"] == 200) {
      UserMoneyDetailsModel? model = UserMoneyDetailsModel.fromJson(result["data"]);
      return model;
    }
    return null;
  }

  static Future<UserMoneyDetailsSearchListModel?>? getUserMoneyDetailsSearch(
      String dateType,int page, String type
      ) async {
    var result = await HttpRequest.request(HttpConfig.getUserMoneyDetailsSearch,
        params: {"dateType":dateType,"page":page,"limit":20,"type":type});
    if (result["code"] == 200) {
      UserMoneyDetailsSearchRespondModel? model = UserMoneyDetailsSearchRespondModel.fromJson(result);
      return model.data;
    }
  }
}