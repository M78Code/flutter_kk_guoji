import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';

import 'activity_logic.dart';
import 'activity_model.dart';
import 'widgets/item_widget.dart';

class ActivityPage extends GetView<ActivityLogic> {

  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityLogic());
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
                "优惠活动",
                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500)),
            SizedBox(
                width: 30.w,
                height: 5.w,
                child: Divider(height: 1,color: Color(0xFF3D35C6),))
          ],
        ),
      ),
      body: _buildView());
  }

  Column _buildView() {
    return Column(
      children: [
        _buildCategoryView(),
        Expanded(
            child: _buildItemsView()
        ),
      ],
    );
  }

  Widget _buildCategoryView() {
    return GetBuilder<ActivityLogic>(
      id: "categoryView",
      builder: (controller){
        return Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: controller.items[index],
                isSelected: controller.selectedCategoryId == controller.items[index].index,
                onTap: (categoryId) {
                  controller.onCategoryTap(categoryId);
                },
              ).paddingOnly(right: 10);
            },
          ),
        ).paddingSymmetric(horizontal: 12.w, vertical: 12.w);
      },
    );
  }

  Widget _buildItemsView() {
    return GetBuilder<ActivityLogic>(
        id: "itemsView",
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: ListView.builder(
                itemCount: controller.activities.length,
                itemBuilder: (context, index) {
                  return FittedBox(
                    child: ActivityItem(activity: controller.activities[index]),
                  );
                }
            ),
          );
        });
  }

}
