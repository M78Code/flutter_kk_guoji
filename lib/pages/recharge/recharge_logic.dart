import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../activity/list/activity_model.dart';

class RechargeLogic extends GetxController {
  final ImageRadioController imageController = ImageRadioController();

  /// 充值控制器
  final TextEditingController rechargeController = TextEditingController();

  RxString tg = "".obs;
  String tgUrl = "";

  ///选择的值默认50¥
  RxInt selectedValue = 0.obs;
  List<CategoryModel> options = [
    CategoryModel(index: 1, name: "50 ¥"),
    CategoryModel(index: 2, name: "100 ¥"),
    CategoryModel(index: 3, name: "200 ¥"),
    CategoryModel(index: 4, name: "300 ¥"),
    CategoryModel(index: 5, name: "500 ¥"),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    getTgAccount();
    super.onInit();
  }

  void onCategoryTap(int categoryId) {
    selectedValue.value = categoryId;
    update(["_buildRechargeCategoryView", "itemsView"]);
  }

  void getTgAccount() async {
    final response = await HttpService.request(HttpConfig.rechargeCustomer);
    if (response["code"] == 200) {
      final json = response["data"];
      final model = UserInfoModel.fromJson(json);
      tg.value = model.siteRechargeTelegram ?? "";
      tgUrl = model.siteRechargeTelegramUrl ?? "";
    }
    print("response = $response");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    imageController.dispose();
    rechargeController.dispose();
    print("Getx---GetxController---dispose方法");
    super.dispose();
  }
}
