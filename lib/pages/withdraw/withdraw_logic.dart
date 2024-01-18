import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/pages/withdraw/coin_model.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/string_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

///提现控制类
class WithdrawLogic extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late Animation<double> rotationAnimation = Tween<double>(
    begin: 0.0,
    end: 720.0,
  ).animate(animationController);

  final ImageRadioController imageController = ImageRadioController();

  ///姓名controller
  final TextEditingController nameController = TextEditingController();

  ///收款账户controller
  final TextEditingController addressController = TextEditingController();

  ///提款金额controller
  TextEditingController amountController = TextEditingController();

  ///提现密码
  TextEditingController withdrawPsdController = TextEditingController();
  final RxBool showPsd = true.obs;
  UserInfoModel? userInfoModel; //用户信息类

  //是否启用提交按钮
  bool isSubmit = false;

  RxInt coinCategoryIndex = 1.obs;
  RxString coinName = "USDT".obs;
  RxInt selectTypeIndex = 1.obs;
  RxList<CategoryModel> options = <CategoryModel>[].obs;

  // List<CoinModel> options = [
  //   CategoryModel(index: 1, name: "USDT", imgPath: Assets.imagesIconUsdt),
  //   // CategoryModel(index: 2, name: "BRL", imgPath: Assets.imagesIconUsdt),
  // ];

  void onCoinCategoryUpdate(CategoryModel category) {
    coinCategoryIndex.value = category.index ?? -1;
    coinName.value = category.name ?? "";
    // print("categoryId: $categoryId");
    selectTypeIndex.value = 1;
  }

  List<CategoryModel> typeOptions = [
    CategoryModel(index: 1, name: "TRC20"),
    CategoryModel(index: 2, name: "ERC20"),
    CategoryModel(index: 3, name: "Polygon"),
    CategoryModel(index: 4, name: "Solana"),
  ];

  // Map<int, List<CategoryModel>> typeOptions = {
  //   1: [
  //     CategoryModel(index: 1, name: "CPF"),
  //     CategoryModel(index: 2, name: "TRC"),
  //   ],
  //   2: [
  //     CategoryModel(index: 1, name: "CNPJ"),
  //     CategoryModel(index: 2, name: "EMAIL"),
  //     CategoryModel(index: 3, name: "PHONE"),
  //     CategoryModel(index: 4, name: "EVP"),
  //   ]
  // };

  @override
  void onInit() {
    // TODO: implement onInit

    userInfoModel = Get.find<UserService>().userInfoModel.value;
    getCurrency();
    super.onInit();
  }

  void onSelectCategoryUpdate(int index) {
    selectTypeIndex.value = index;
  }

  RxDouble withdrawAmount = 0.00.obs; //提款金额
  RxDouble withTotalAmount = 0.00.obs; //提款总额
  void calcAmount(String text) {
    if (text.isNotEmpty) {
      // withdrawAmount.value = double.parse(text);
      //提款总额计算 2%手续费
      withTotalAmount.value =
          double.parse(text) - double.parse(StringUtil.formatNum(double.parse(text) * 0.02, 2));
    } else {
      // withdrawAmount.value = 0.0;
      withTotalAmount.value = 0.0;
    }
    final coinNet = typeOptions[selectTypeIndex.value].name;
    if (coinName.value.isNotEmpty &&
        null != coinNet &&
        coinNet.isNotEmpty &&
        addressController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      if (userInfoModel?.withdrawPwdStatus == 1) {
        if (withdrawPsdController.text.isNotEmpty) {
          //可以点击
          isSubmit = true;
        } else {
          //不可以点击
          isSubmit = false;
        }
      } else {
        //可以点击
        isSubmit = true;
      }
    } else {
      //不可以点击
      isSubmit = false;
    }
    update(["WithdrawPage"]);
  }

  void updateUserInfo() async {
    final service = UserService.to;
    await service.fetchUserMoney();
    await service.fetchUserInfo();
    userInfoModel = service.userInfoModel.value;
    update(["WithdrawPage"]);
  }

  ///获取提现币种
  void getCurrency() async {
    var result = await HttpRequest.request(HttpConfig.currency);
    if (result["code"] == 200) {
      final json = result["data"];
      json.forEach((v) {
        options.add(CategoryModel.fromJson(v));
      });
    }
    // print("result = $result");
    // if (result["code"] == 200) {
    // ShowToast.showToast("设置提现密码成功");
    // RouteUtil.popView();
    // } else {
    //   ShowToast.showToast(result["message"]);
    // }
  }

  ///提现操作
  Future<bool> withdrawSubmit() async {
    if (coinName.value.isEmpty) {
      ShowToast.showToast("请选择提现货币");
      return false;
    }
    final coinNet = typeOptions[selectTypeIndex.value].name;
    if (null == coinNet || coinNet.isEmpty) {
      ShowToast.showToast("请选择网络");
      return false;
    }
    if (addressController.text.isEmpty) {
      ShowToast.showToast("请输入${coinName.value}提现地址");
      // ShowToast.showToast("您输入的提示密码错误次数已达3次，提款被锁定，请联系客服或5分钟后重试");
      return false;
    }
    if (amountController.text.isEmpty) {
      ShowToast.showToast("请输入提现金额");
      return false;
    }
    double useMoney = double.parse(UserService.to.userMoneyModel?.money ?? "0.00");
    if (double.parse(amountController.text) > useMoney) {
      ShowToast.showToast("余额不足");
      return false;
    }
    if (userInfoModel?.withdrawPwdStatus == 1) {
      if (withdrawPsdController.text.isEmpty) {
        ShowToast.showToast("请输入提现密码");
        return false;
      }
    }

    final map = {
      "currency_code": coinName.value,
      "type": coinNet,
      "money": amountController.text.trim(),
      "account": nameController.text,
      "account_number": addressController.text,
      "real_money": withTotalAmount.value,
      "withdraw_pwd": withdrawPsdController.text
    };

    var result = await HttpRequest.request(HttpConfig.withdraw, method: "post", params: map);
    if (result["code"] == 200) {
      final service = UserService.to;
      final response1 = await service.fetchUserMoney();
      final response2 = await service.fetchUserInfo();
      return true;
      service.fetchUserMoney().then((value) => service.fetchUserInfo().then((value) {
            return true;
          }));
    } else {
      ShowToast.showToast(result["message"]);
    }
    return false;
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
    addressController.dispose();
    amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void clearInput() {
    nameController.text = "";
    addressController.text = "";
    amountController.text = "";
    withdrawPsdController.text = "";
    update(["WithdrawPage"]);
  }
}
