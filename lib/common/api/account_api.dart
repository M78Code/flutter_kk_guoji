
import 'package:kkguoji/common/models/mine_wallet/user_money_details_model.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/common/models/user_money_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

import '../models/mine_wallet/user_money_details_search_respond_model.dart';
import '../models/mine_wallet/user_recharge_list_respond_model.dart';
import '../models/mine_wallet/user_withdraw_list_respond_model.dart';

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
    var result = await HttpRequest.request(HttpConfig.getUserMoneyDetails, method: "post");
    if(result["code"] == 200) {
      UserMoneyDetailsModel? model = UserMoneyDetailsModel.fromJson(result["data"]);
      return model;
    }
    return null;
  }

  static Future<UserMoneyDetailsSearchListModel?>? getUserMoneyDetailsSearch(
      String dateType,int page, String type
      ) async {
    var result = await HttpRequest.request(HttpConfig.getUserMoneyDetailsSearch, method: "post",
        params: {"dateType":dateType,"page":page,"limit":20,"type":type});
    if (result["code"] == 200) {
      UserMoneyDetailsSearchRespondModel? model = UserMoneyDetailsSearchRespondModel.fromJson(result);
      return model.data;
    }
  }

  // yesterday=昨日，today=今日，last_week=上周，week=本周，month=本月，last_month=上月 Y-m-d - Y-m-d 自定义范围
  static Future<UserWithdrawListModel?>? getUserWithdrawList(
      String time_range,int page, String type
      ) async {
    var result = await HttpRequest.request(HttpConfig.getUserWithdrawList, method: "get",
        params: {"time_range":time_range,"page":page,"limit":20});
    if (result["code"] == 200) {
      UserWithdrawListRespondModel? model = UserWithdrawListRespondModel.fromJson(result);
      return model.data;
    }
  }

  // yesterday=昨日，today=今日，last_week=上周，week=本周，month=本月，last_month=上月 Y-m-d - Y-m-d 自定义范围
  static Future<UserRechargeListModel?>? getUserRechargeList(
      String time_range,int page, String type
      ) async {
    var result = await HttpRequest.request(HttpConfig.getUserRechargeList, method: "get",
        params: {"time_range":time_range,"page":page,"limit":20});
    if (result["code"] == 200) {
      UserRechargeListRespondModel? model = UserRechargeListRespondModel.fromJson(result);
      return model.data;
    }
  }
}