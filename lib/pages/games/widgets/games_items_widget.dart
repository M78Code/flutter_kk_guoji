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
        return PageView.builder(
          itemCount: controller.groupGameDatas.length,
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.switchIndex(index);
          },
          itemBuilder: (context, index) {
            var menu = controller.menuList[index];
            var gameModels =  controller.groupGameDatas.firstWhere((element) {
              return  element.id.toString() == menu[4];
            });
            if (menu[4] == "4") {
              return SingleChildScrollView(child: _buildItemsGridView3(gameModels.list ?? []));
            }
            else if (menu[4] == "3") {
              return SingleChildScrollView(child: _buildItemsGridView02(controller.lottryGameModels));
            }
            else {
              return SingleChildScrollView(child: _buildItemsGridView02(gameModels.list ?? []));
            }
          },
        );
      },
    );
  }

  // Widget _buildItemListView(List<List<String>> items) {
  //
  //   List<Widget> widgets = [SizedBox(height: 12.w,),];
  //   for (var index = 0; index < items.length; index++)
  //     widgets.add(Image.asset(items[index].first, height: 123.w)
  //         .paddingOnly(bottom: 12.w)
  //         .onTap(() {
  //       if (UserService.to.isLogin == false) {
  //         RouteUtil.pushToView(Routes.loginPage);
  //         return;
  //       }
  //       controller.gamesOnTap(items[index]);
  //     }));
  //   return Column(
  //     children: widgets,
  //   );
  // }
  //
  // GridView _buildItemsGridView(List<List<String>> items) {
  //   return GridView.builder(
  //     padding: EdgeInsets.only(top: 0, left: 12.w, right: 12.w, bottom: 10.w),
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 3,
  //         crossAxisSpacing: 8.0,
  //         mainAxisSpacing: 12.w,
  //         childAspectRatio: 220 / 292
  //     ),
  //     itemCount: items.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         child: Image.asset(items[index].first, width: 78.w, height: 78.w),
  //       ).onTap(() {
  //         if(items[index][2] != "JCP") {
  //           if (UserService.to.isLogin == false) {
  //             RouteUtil.pushToView(Routes.loginPage);
  //             return;
  //           }
  //         }
  //         // controller.gamesOnTap(items[index]);
  //       }); // Passing index + 1 as item number
  //     },
  //   );
  // }

  GridView _buildItemsGridView02(List<GameModel> games) {
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
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        GameModel gameModel = games[index];
        return Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: Image.network(
                  gameModel.image ?? "", width: 78.w, height: 78.w, fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 4,
              right: 4,
              bottom: 8.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  gameModel.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
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

  GridView _buildItemsGridView3(List<GameModel> games) {
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
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
        GameModel gameModel = games[index];
        return Stack(
          children: [
            Positioned.fill(child: Image.network(gameModel.image ?? "", width: 78.w, height: 78.w)),
            Positioned(
              left: 2,
              right: 2,
              bottom: 8.w,
              child: Text(
                gameModel.name ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
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