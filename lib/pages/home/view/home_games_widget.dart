import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../logic/logic.dart';

class KKHomeGamesWidget extends StatelessWidget {
  KKHomeGamesWidget({super.key});

  final controller = Get.find<HomeLogic>();
  final mainController = Get.find<MainPageLogic>();
  final _itemRatio = 584 / 441;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/home/huojian.png', width: 24, height: 21,),
                    SizedBox(width: 5,),
                    Text("推荐游戏", style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),),
                  ],
                ),
              ],
            ),
            InkWellView(
              onPressed: () => mainController.clickTabBarItem(1),
              child: Row(
                children: [
                  Text(
                    "查看全部",
                    style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.sp),
                  ),
                  SizedBox(height: 5.w),
                  Icon(
                    Icons.chevron_right_outlined,
                    size: 24.w,
                    color: Color(0xFFB2B3BD),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15.w),
        SizedBox(
          width: double.infinity,
          height: _calculateGridViewHeight(context),
          child: Obx(() {
            return GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.recommendGameListNew.length,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: _itemRatio, crossAxisSpacing: 10.w, mainAxisSpacing: 12.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xFF24262F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.w), // 设置圆角半径
                            child: Image.network(
                              controller.recommendGameListNew[index].image,
                              height: _calculateGridViewHeight(context),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                height: 30.w,
                                alignment: Alignment.center,
                                child: Text(
                                  controller.recommendGameListNew[index].name,
                                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w500,),
                                )),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      controller.openTickGame();
                    },
                  );
                });
          }),
        ),
      ],
    );
  }

  double _calculateItemViewHeight(BuildContext context) {
    double crossAxisSpacing = 12.w; // 纵向间距
    int crossAxisCount = 3; // 一行显示三个
    int itemCount = 6; // 两排共六个项
    double itemWidth = (MediaQuery
        .of(context)
        .size
        .width - 10.w * 2 - 12.w * 2) / 3;
    double itemHeight = _itemRatio * itemWidth; // 每个项的高度
    return itemHeight;
  }

  double _calculateGridViewHeight(BuildContext context) {
    double crossAxisSpacing = 12.w; // 纵向间距
    int crossAxisCount = 3; // 一行显示三个
    int itemCount = 6; // 两排共六个项
    double itemWidth = (MediaQuery
        .of(context)
        .size
        .width - 10.w * 2 - 12.w * 2) / 3;
    double itemHeight = _itemRatio * itemWidth; // 每个项的高度
    double totalHeight = itemHeight * 2 + crossAxisSpacing;
    return totalHeight;
  }
}
