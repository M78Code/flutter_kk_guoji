import 'package:kkguoji/common/models/game_login.dart';
import 'package:kkguoji/common/models/group_game_list_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

import '../models/game/game_list_response_model.dart';
import '../models/game_type_list_response_model.dart';
import '../models/get_game_model.dart';


class GamesApi {
  /// 分类列表
  static Future<GroupGameListModel?>? games() async {
    var result = await HttpRequest.request(HttpConfig.getGroupGameList,params: {"is_mobile":"1", "limit":"30"}, method: "get");
    if (result["code"] == 200) {
      GroupGameListModel? model = GroupGameListModel.fromJson(result);
      return model;
    }
  }

  static Future<GetGameModel?>? getGameByCompanyCode(String game_company_code, String gameCode) async {
    var result = await HttpRequest.request(HttpConfig.getGameByCompanyCode,method: "get" ,params: {"company_code":game_company_code});
    if (result["code"] == 200 && result["data"] != null) {
      if (gameCode.length > 0) {
        return GetGameModel.fromJson(result["data"][gameCode]);
      }
      Map<String, dynamic> jsonMap = result["data"];
      return GetGameModel.fromJson(jsonMap.values.firstOrNull);
    }
  }

  static Future<GameLogin?>? gameLogin(String game_company_code, String game_id) async {
    var result = await HttpRequest.request(HttpConfig.loginGame, method: "post",params: {"game_company_code":game_company_code, "game_id": game_id, "home_url":""});
    if (result["code"] == 200 && result["data"] != null ) {

      return GameLogin.fromJson(result["data"]);
    }
  }

  static Future<List<GameTypeModel>?> getGameTypeList() async {
    var result = await HttpRequest.request(HttpConfig.getGameTypeList, method: "post");
    if (result["code"] == 200 && result["data"] != null ) {
      return GameTypeListResponseModel.fromJson(result).data;
    }
  }
  static Future<GameListModel?> getGameList(int? type) async {
    var result = await HttpRequest.request(HttpConfig.getGameList,
        method: "post",params: type != null ? {"type":type, "page":1,"limit":1000} : {"page":1,"limit":1000});
    if (result["code"] == 200 && result["data"] != null ) {
      return GameListResponseModel.fromJson(result).data;
    }
  }
}