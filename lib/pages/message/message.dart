import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/activity_logic.dart';
import 'package:kkguoji/pages/activity/list/widgets/item_widget.dart';
import 'package:kkguoji/pages/message/message_list.dart';

class MessageCenterPage extends StatefulWidget {
  const MessageCenterPage({super.key});

  @override
  State<MessageCenterPage> createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
        leading: IconButton(
            padding: const EdgeInsets.all(16.0),
            iconSize: 20,
            onPressed: () {
              print('返回');
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
      ),
      body: _buildView(),
    );
  }

  Column _buildView() {
    return Column(
      children: [
        _buildSelectionView(),
        const Divider(
          color: Color.fromRGBO(255, 255, 255, 0.06),
          height: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 15),
        Expanded(child: _tabbleView()),
      ],
    );
  }

  Widget _buildSelectionView() {
    return GetBuilder<ActivityLogic>(
      id: "categoryView",
      builder: (controller) {
        return Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.messageSelectBar.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: controller.selectBar[index],
                isSelected: controller.selectedCategoryId ==
                    controller.items[index].index,
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

  Widget _tabbleView() {
    return GetBuilder<ActivityLogic>(
        id: "itemsView",
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: ListView.builder(
                shrinkWrap: true,
                // itemCount: controller.activities.length,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return MeeageListView();
                  // return const FittedBox(
                  //   child: MeeageListView(
                  //       // activity: controller.activities[index],
                  //       // onTap: (activityId) {
                  //       //   controller.onActivityTap(activityId);
                  //       // },
                  //       ),
                  // );
                }),
          );
        });
  }
}
