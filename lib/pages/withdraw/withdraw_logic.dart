import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/string_util.dart';

///提现控制类
class WithdrawLogic extends GetxController {
  final userService = Get.find<UserService>();

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
    CategoryModel(index: 1, name: "RMB", imgPath: Assets.withdrawIconCc),
    CategoryModel(index: 2, name: "BRL", imgPath: Assets.withdrawIconCc),
  ];

  void onCoinCategoryUpdate(int categoryId) {
    coinCategoryIndex.value = categoryId;
    print("categoryId: $categoryId");
    selectTypeIndex.value = 1;
  }

  Map<int, List<CategoryModel>> typeOptions = {
    1: [
      CategoryModel(index: 1, name: "CPF", imgPath: Assets.withdrawIconCc),
      CategoryModel(index: 2, name: "TRC", imgPath: Assets.withdrawIconCc),
    ],
    2: [
      CategoryModel(index: 1, name: "CNPJ", imgPath: Assets.withdrawIconCc),
      CategoryModel(index: 2, name: "EMAIL", imgPath: Assets.withdrawIconCc),
      CategoryModel(index: 3, name: "PHONE", imgPath: Assets.withdrawIconCc),
      CategoryModel(index: 4, name: "EVP", imgPath: Assets.withdrawIconCc),
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
      withTotalAmount.value = double.parse(StringUtil.formatNum(double.parse(text) * 0.02, 2));
    } else {
      withdrawAmount.value = 0.0;
      withTotalAmount.value = 0.0;
    }
  }

  ///提现操作
  void withdrawSubmit() {
    if (userService.isBindEmail) {
      ///提现接口请求
    } else {
      RouteUtil.pushToView(Routes.bindEmail);
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
    nameController.dispose();
    accountController.dispose();
    amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
