import 'package:kkguoji/common/models/game_login.dart';
import 'package:kkguoji/common/models/group_game_list_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class GamesApi {
  /// 分类列表
  static Future<GroupGameListModel?>? games() async {
    var result = await HttpRequest.request(HttpConfig.getGroupGameList,params: {"is_mobile":"1", "limit":"30"});
    if (result["code"] == 200) {
      GroupGameListModel? model = GroupGameListModel.fromJson(result);
      return model;
    }
  }

  static Future<GameLogin?>? gameLogin(String game_company_code, String game_id) async {
    var result = await HttpRequest.request(HttpConfig.loginGame, method: "post",params: {"game_company_code":game_company_code, "game_id": game_id, "home_url":""});
    if (result["code"] == 200 && result["data"] != null ) {

      return GameLogin.fromJson(result["data"]);
    }
  }
}