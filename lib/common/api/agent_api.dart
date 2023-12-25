import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

import '../../pages/promotion/model/promotion_model.dart';

class AgentApi {

  static Future<KKPromotionModel?> getAgentTeam() async {
    var result = await HttpRequest.request(HttpConfig.getAgentTeam, method: "get");
    if (result["code"] == 200) {
      return KKPromotionModel.fromJson(result["data"]);;
    }
    return null;
  }

}