import 'package:get/get.dart';

import '../../activity/list/activity_model.dart';

class ClaimRecordLogic extends GetxController {
  RxInt selectedCategoryId = 0.obs;

  List<String> messageSelectBar = ["全部奖励", "任务奖励", "一般奖励", "贵宾奖励"];
  late List<CategoryModel> selectBar = List.generate(messageSelectBar.length,
      (index) => CategoryModel(index: index, name: messageSelectBar[index]));

  void onCategoryTap(int categoryId) {
    selectedCategoryId.value = categoryId;
    update(["categoryView", "itemsView"]);
  }
}
