import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/promotion/model/promotion_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';

class PromotionLogic extends GetxController {

  Rx<KKPromotionModel?> promotionModel = Rx<KKPromotionModel?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAgentTeam();
  }
  
  void getAgentTeam() async{
    var result = await HttpRequest.request(HttpConfig.getAgentTeam);
    if(result["code"] == 200) {
      promotionModel.value = KKPromotionModel.fromJson(result["data"]);
    }
  }
}