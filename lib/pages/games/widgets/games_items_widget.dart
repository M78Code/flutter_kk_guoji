import 'dart:ffi';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common//extension/index.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../../common/models/group_game_list_model.dart';
import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';
import '../games_logic.dart';

class GamesItemsWidget extends GetView<GamesLogic> {

  GamesItemsWidget({
    Key? key,
  }) : super(key: key) { }


  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return GetBuilder<GamesLogic>(
      id: "games",
      builder: (controller) {
        controller.pageController = PageController(initialPage: controller.currentIndex);;
        return Column(
          children: [
            // Expanded(
            //   child: PageView.builder(
            //     itemCount: controller.gameModels.length,
            //     controller: controller.pageController,
            //     onPageChanged: (index) {
            //       controller.switchIndex(index);
            //     },
            //     itemBuilder: (context, index) {
            //       return SingleChildScrollView(child: _buildItemsGridView02(controller.gameModels[index]),);
            //     },
            //   ),
            // ),

            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.switchIndex(index);
                },
                children: [
                  SingleChildScrollView(child: _buildItemsGridView(controller.hotList),),
                  SingleChildScrollView(child: _buildItemsGridView(controller.lotteryList),),
                  SingleChildScrollView(child: _buildItemsGridView(controller.realList),),
                  SingleChildScrollView(child: _buildItemsGridView3(controller.sportList),),
                ],
              )
            )
          ],
        );
      },
    );
  }

  Widget _buildItemListView(List<List<String>> items) {

    List<Widget> widgets = [SizedBox(height: 12.w,),];
    for (var index = 0; index < items.length; index++)
      widgets.add(Image.asset(items[index].first, height: 123.w)
          .paddingOnly(bottom: 12.w)
          .onTap(() {
        if (UserService.to.isLogin == false) {
          RouteUtil.pushToView(Routes.loginPage);
          return;
        }
        controller.gamesOnTap(items[index]);
      }));
    return Column(
      children: widgets,
    );

  }
  GridView _buildItemsGridView(List<List<String>> items) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 0, left: 12.w, right: 12.w, bottom: 10.w),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.w,
          childAspectRatio: 220 / 292
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image.asset(items[index].first, width: 78.w, height: 78.w),
        ).onTap(() {
          if (UserService.to.isLogin == false) {
            RouteUtil.pushToView(Routes.loginPage);
            return;
          }
          controller.gamesOnTap(items[index]);
        }); // Passing index + 1 as item number
      },
    );
  }

  GridView _buildItemsGridView3(List<List<String>> items) {
    return GridView.builder(
      padding: EdgeInsets.only( left: 15.w, right: 15.w, bottom: 10.w),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 12.w,
          childAspectRatio: 338 / 292
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image.asset(items[index].first, width: 78.w, height: 78.w),
        ).onTap(() {
          if (UserService.to.isLogin == false) {
            RouteUtil.pushToView(Routes.loginPage);
            return;
          }
          controller.gamesOnTap(items[index]);
        }); // Passing index + 1 as item number
      },
    );
  }

  GridView _buildItemsGridView02(GroupGameData groupGameData) {

    List<GameModel>? games = (groupGameData.list ?? []);
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
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        GameModel gameModel = games[index];
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(gameModel.image ?? "", width: 78.w, height: 78.w),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  gameModel.name ?? "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ).marginOnly(top: 8.w, bottom: 8.w)
            ],
          ),
        ).onTap(() {
          if (UserService.to.isLogin == false) {
            RouteUtil.pushToView(Routes.loginPage);
            return;
          }
          controller.gamesOnTapFormApi(gameModel);
        }); // Passing index + 1 as item number
      },
    );
  }
}