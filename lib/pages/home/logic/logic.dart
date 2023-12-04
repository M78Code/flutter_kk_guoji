
import 'package:get/get.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_request.dart';
import 'dart:core';

class HomeLogic extends GetxController {

  final RxString marqueeStr = "".obs;
  final RxList bannerList = [].obs;
  final RxList ticketList = [].obs;
  final RxMap imageMap = {
    "XGLHC":{"bg_icon":"assets/images/home_xianggangliuhecai.png", "logo_icon":"assets/images/home_liuhecai_icon.png"},
    "PCNN":{"bg_icon":"assets/images/home_pcniuniu.png", "logo_icon":"assets/images/home_pcniuniu_icon.png"},
    "PCBJL":{"bg_icon":"assets/images/home_pcbaijiale.png", "logo_icon":"assets/images/home_pcbaijiale_icon.png"},
    "JNDSI":{"bg_icon":"assets/images/home_jianada42.png", "logo_icon":"assets/images/home_jianada42_icon.png"},
    "JNDWU":{"bg_icon":"assets/images/home_jianada5.png", "logo_icon":"assets/images/home_jianada50_icon.png"},
    "JNDWP":{"bg_icon":"assets/images/home_jianadawangpan.png", "logo_icon":"assets/images/home_jianadawangpan_icon.png"},
    "JNDEB":{"bg_icon":"assets/images/home_jianada28.png", "logo_icon":"assets/images/home_jianada28_icon.png"},
    "JNDSSC":{"bg_icon":"assets/images/home_jianadashishicai.png", "logo_icon":"assets/images/home_jianadashishicai_icon.png"},


  }.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    var result = await HttpRequest.request(HttpConfig.getMarqueeNotice);
    if(result["code"] == 200) {
      List marquees = result["data"];
      if(marquees.isNotEmpty) {
        Map m = marquees.first;
        marqueeStr.value = m["content"];
      }
    }


    var gameResult = await HttpRequest.request(HttpConfig.getJCPGameList, method: "post");
    if(gameResult["code"] == 200) {
      List data = gameResult["data"];
      if(data.isNotEmpty) {
       List newData = data.where((element) {
          String lotteryCode = element["lotteryCode"];
          return lotteryCode != "HXEB"  && lotteryCode != "QXC";
        }).toList();
       List ticketList = constructList(2, newData);
       this.ticketList.value = ticketList;
        // data.forEach((element) {
        //   String lotteryCode = element["lotteryCode"];
        //   if() {
        //
        //   }
        // });
      }

    }

    Map<String, dynamic> bannerParms = {"position":"home_banner"};
    var bannerResult = await HttpRequest.request(HttpConfig.getBannerList, params: bannerParms);
    if(bannerResult["code"] == 200) {
      bannerList.value = bannerResult["data"];
    }
  }

  List constructList(int len, List list) {
    var length = list.length; //列表数组数据总条数
    List result = []; //结果集合
    int index = 1;
    //循环 构造固定长度列表数组
    while (true) {
      if (index * len < length) {
        List temp = list.skip((index - 1) * len).take(len).toList();
        result.add(temp);
        index++;
        continue;
      }
      List temp = list.skip((index - 1) * len).toList();
      result.add(temp);
      break;
    }
    return result;
  }


}