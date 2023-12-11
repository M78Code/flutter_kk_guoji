import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../activity/list/activity_model.dart';

class RechargeLogic extends GetxController {
  final ImageRadioController imageController = ImageRadioController();

  /// 充值控制器
  final TextEditingController rechargeController = TextEditingController();

  ///选择的值默认50¥
  RxInt selectedValue = 0.obs;
  List<CategoryModel> options = [
    CategoryModel(index: 1, name: "50"),
    CategoryModel(index: 2, name: "100"),
    CategoryModel(index: 3, name: "200"),
    CategoryModel(index: 4, name: "300"),
    CategoryModel(index: 5, name: "500"),
  ];

  void onCategoryTap(int categoryId){
    selectedValue.value = categoryId;
    update(["_buildRechargeCategoryView", "itemsView"]);
  }

  ///充值
  void recharge() async {
   final amount = rechargeController.value.text;
   if(amount.isEmpty){
     ShowToast.showToast("请输入充值金额");
     return;
   }
   print("amount:$amount");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("Getx---GetxController---onReady方法");
    super.onReady();
    print("传参值+${Get.arguments}");
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
