import 'package:kkguoji/services/config.dart';
import '../../../services/http_service.dart';

class MessageService {
  //公告类型
  static getNoticeSubType() async {
    var result =
        await HttpRequest.request(HttpConfig.getNoticeSubType, method: "get");
    return result;
  }

  //公告列表
  static getMessages(int type, int page) async {
    var result = await HttpRequest.request(HttpConfig.getMessageList,
        method: "get", params: {"sub_type": type, "page": page, "limit": 10});
    return result;
  }

//系统公告设置已读
  static getReadNotice(int id) async {
    // ignore: unused_local_variable  //系统公告ID
    var result = await HttpRequest.request(HttpConfig.readNotice,
        method: "post", params: {"id": id});
    if (result['code'] == 200) {}
  }
}
