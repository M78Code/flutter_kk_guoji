
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../generated/assets.dart';
import 'activity_model.dart';

class ActivityLogic extends GetxController {

  RxInt selectedCategoryId = 0.obs;
  List<String> itemNames = ["全部活动","新人专属","彩票专属","视讯专属"];
  late List<CategoryModel> items = List.generate(
      itemNames.length,
          (index) => CategoryModel(index: index, name: itemNames[index]));
// 假设的活动数据，格式为 ActivityModel 类型的列表
  List<ActivityModel> activities = [
    ActivityModel(id: 0, imageUrl: Assets.imagesActivity),
    ActivityModel(id: 1, imageUrl: Assets.imagesActivity),
    ActivityModel(id: 2, imageUrl:  Assets.imagesActivity),
    ActivityModel(id: 3, imageUrl:  Assets.imagesActivity),
    // 添加更多活动项
  ];
  void onCategoryTap(int categoryId) {
    selectedCategoryId.value = categoryId;
    update(["categoryView", "itemsView"]);
  }
  void onActivityTap(int activityId) {
    // Get.toNamed(
    //   RouteNames.goodsCategory,
    //   arguments: {
    //     "id": categoryId,
    //   },
    // );
  }
}