import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/utils/string_util.dart';

///提现控制类
class WithdrawLogic extends GetxController {
  final ImageRadioController imageController = ImageRadioController();

  ///姓名controller
  final TextEditingController nameController = TextEditingController();

  ///收款账户controller
  final TextEditingController accountController = TextEditingController();

  ///提款金额controller
  TextEditingController amountController = TextEditingController();

  RxInt coinCategoryIndex = 1.obs;
  RxInt selectTypeIndex = 1.obs;
  List<CategoryModel> options = [
    CategoryModel(index: 1, name: "RMB", imgPath: Assets.iconCCPng),
    CategoryModel(index: 2, name: "BRL", imgPath: Assets.iconCCPng),
  ];

  void onCoinCategoryUpdate(int categoryId) {
    coinCategoryIndex.value = categoryId;
    print("categoryId: $categoryId");
    selectTypeIndex.value = 1;
  }

  Map<int, List<CategoryModel>> typeOptions = {
    1: [
      CategoryModel(index: 1, name: "CPF", imgPath: Assets.iconCCPng),
      CategoryModel(index: 2, name: "TRC", imgPath: Assets.iconCCPng),
    ],
    2: [
      CategoryModel(index: 1, name: "CNPJ", imgPath: Assets.iconCCPng),
      CategoryModel(index: 2, name: "EMAIL", imgPath: Assets.iconCCPng),
      CategoryModel(index: 3, name: "PHONE", imgPath: Assets.iconCCPng),
      CategoryModel(index: 4, name: "EVP", imgPath: Assets.iconCCPng),
    ]
  };

  void onSelectCategoryUpdate(int index) {
    selectTypeIndex.value = index;
    // update(["_buildCoinSelectType", "itemsView"]);
  }

  RxDouble withdrawAmount = 0.00.obs; //提款金额
  RxDouble withTotalAmount = 0.00.obs; //提款总额
  void calcAmount(String text) {
    if (text.isNotEmpty) {
      withdrawAmount.value = double.parse(text);
      //提款总额计算 2%手续费
      withTotalAmount.value =
          double.parse(StringUtil.formatNum(double.parse(text) * 0.02, 2));
    } else {
      withdrawAmount.value = 0.0;
      withTotalAmount.value = 0.0;
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    imageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
