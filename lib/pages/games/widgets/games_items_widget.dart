import 'dart:ffi';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common//extension/index.dart';

import '../../../generated/assets.dart';
import '../games_logic.dart';

class GamesItemsWidget extends StatelessWidget {

  late GamesLogic controller = Get.find<GamesLogic>();

  GamesItemsWidget({
    Key? key,
  }) : super(key: key) { }


  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Column(
      children: [
        _buildTitleView().marginOnly(top: 18.w, left: 19.w),

        Expanded(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.switchIndex(index);
            },
            children: [
              SingleChildScrollView(child: _buildItemsGridView(),),
              SingleChildScrollView(child: _buildItemListView(),),
              SingleChildScrollView(child: _buildItemListView(),),
              SingleChildScrollView(child: _buildItemListView(),),
            ],
          )
        )
      ],
    ).decorated(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF262E47), // Replace with your color stops
            Color(0xFF181E2F),
          ],
          stops: [0.0, 1.0],
        ),
        color: Color(0xFF262D47),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.w), topRight: Radius.circular(28.w))
    );
  }

  Widget _buildTitleView() {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.w),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                [Color(0xFFF07027), Color(0xFFE2951C)],
                [Color(0xFF279CF0), Color(0xFF3D4AF7)],
                [Color(0xFFB027F0), Color(0xFF7C1DDA)],
                [Color(0xFF17A62E), Color(0xFF17A62E)],
              ][controller.currentIndex.value],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        Text(
            controller.menuList[controller.currentIndex.value][3],
            style: TextStyle(color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400))
            .marginOnly(left: 8.w),
      ],
    );
  }

  Widget _buildItemsView() {
    return controller.currentIndex == 0 ? _buildItemsGridView() : _buildItemListView();
  }

  Widget _buildItemListView() {

    List<Widget> widgets = [SizedBox(height: 12.w,),];
    for (var index = 0; index < controller.realList.length; index++)
      widgets.add(Image.asset(controller.realList[index].first, height: 123.w)
          .paddingOnly(bottom: 12.w)
          .onTap(() { }));
    return Column(
      children: widgets,
    );

  }
  GridView _buildItemsGridView() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 14.w, left: 15.w, right: 15.w),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.w,
          childAspectRatio: 155 / 216
      ),
      itemCount: controller.lotteryList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(controller.lotteryList[index].first, width: 78.w, height: 78.w),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  controller.lotteryList[index][1],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ).marginOnly(top: 8.w, bottom: 8.w)
            ],
          ),
        ); // Passing index + 1 as item number
      },
    );
  }
}