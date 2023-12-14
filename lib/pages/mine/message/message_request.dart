import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';

class MessageRequest extends GetxController {
  RxInt selectedCategoryId = 0.obs;

  ///消息中心
  List<String> messageSelectBar = ["全部活动", "通知活动", "系统公告"];
  late List<CategoryModel> selectBar = List.generate(messageSelectBar.length,
      (index) => CategoryModel(index: index, name: messageSelectBar[index]));

  void onCategoryTap(int categoryId) {
    selectedCategoryId.value = categoryId;

    update(["categoryView", "itemsView"]);
  }
}
