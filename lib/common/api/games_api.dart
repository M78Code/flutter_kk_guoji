import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_request.dart';

class GamesApi {
  /// 分类列表
  static Future<Map<String, dynamic>> games() async {
      var result = await HttpRequest.request(HttpConfig.getGroupGameList,params: {"is_mobile":"1"});
      if (result["code"] == 200) {

      }
      return result.data;
    }
  }