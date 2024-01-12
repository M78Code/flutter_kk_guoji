import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/widgets/item_widget.dart';
import 'activity_logic.dart';

class ActivityPage extends GetView<ActivityLogic> {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ActivityLogic());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "优惠活动",
            style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: _buildView());
  }

  Column _buildView() {
    return Column(
      children: [
        _buildCategoryView(),
        Divider(
          height: 1,
          color: Colors.white.withOpacity(0.06),
        ),
        Expanded(
            child: controller.activities.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.activityImgComingSoon,
                        width: 83.w,
                        height: 90.h,
                      ),
                      Text(
                        "敬请期待",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ).marginOnly(top: 10.h),
                    ],
                  ))
                : _buildItemsView()),
      ],
    );
  }

  Widget _buildCategoryView() {
    return GetBuilder<ActivityLogic>(
      id: "categoryView",
      builder: (controller) {
        return SizedBox(
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
                    child: ActivityItem(
                      activity: controller.activities[index],
                      onTap: (activityId) {
                        controller.onActivityTap(activityId);
                      },
                    ),
                  );
                }),
          );
        });
  }
}
