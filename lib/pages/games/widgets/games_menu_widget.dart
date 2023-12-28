import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/games/games_logic.dart';

import '../../../common/models/group_game_list_model.dart';
import '../../../generated/assets.dart';

class GamesMenuViewModel {
  String? image;
  String? title;
  String? arrow;

  GamesMenuViewModel( {this.image,this.title,this.arrow});
}
class KKGamesMenuWidget extends GetView<GamesLogic> {

  const KKGamesMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return _buildView();
  }
  Widget _buildView() {
    return GetBuilder<GamesLogic>(
      id: "menu",
      builder: (controller) {

        List<GamesMenuViewModel> viewModels = [];
        for (var i = 0; i < controller.menuList.length; i++) {
          GamesMenuViewModel? viewModel;
          viewModel = GamesMenuViewModel(image: controller.menuList[i][0], arrow: controller.menuList[i][1],title : controller.menuList[i][2]);
          if (viewModel != null) viewModels.add(viewModel);
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
              color: Color(0xFF202138)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < viewModels.length; i++)
                Expanded(
                  child: _buildItem(
                      viewModels[i],
                      i == controller.currentIndex ? 1 : 0.6,
                          () {  controller.menuOntap(i); },
                      i == controller.currentIndex),
                ),
            ],
          ),
        );
      },
    );
  }
  // Widget _buildViewFormApi() {
  //   return GetBuilder<GamesLogic>(
  //     id: "menu",
  //     builder: (controller) {
  //
  //       List<GamesMenuViewModel> viewModels = [];
  //       for (var i = 0; i < controller.gameModels.length; i++) {
  //         GroupGameData game = controller.gameModels[i];
  //         GamesMenuViewModel? viewModel;
  //         switch (game.name ?? "") {
  //           case "热门" :
  //             viewModel = GamesMenuViewModel(image: Assets.gamesGamesHot, arrow: Assets.gamesGamesHotArrow,title :"热门");
  //             break;
  //           case "电子" :
  //             viewModel = GamesMenuViewModel(image: Assets.gamesGamesHot, arrow: Assets.gamesGamesHotArrow,title :"电子");
  //             break;
  //           case "彩票" :
  //             viewModel = GamesMenuViewModel(image: Assets.gamesGamesLottery, arrow: Assets.gamesGamesLotteryArrow,title :"彩票");
  //             break;
  //           case "视讯" :
  //             viewModel = GamesMenuViewModel(image: Assets.gamesGamesVideo, arrow: Assets.gamesGamesVideoArrow,title :"视讯");
  //             break;
  //           case "体育" :
  //             viewModel = GamesMenuViewModel(image: Assets.gamesGamesSports, arrow: Assets.gamesGamesSportsArrow,title :"体育");
  //             break;
  //         }
  //         if (viewModel != null) viewModels.add(viewModel);
  //       }
  //
  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           for (var i = 0; i < viewModels.length; i++)
  //             _buildItem(
  //                 viewModels[i],
  //                 i == controller.currentIndex ? 1 : 0.6,
  //                     () {  controller.menuOntap(i); },
  //                 i == controller.currentIndex).marginOnly(left: i == 0 ? 0 : 20.w),
  //         ],
  //       ).marginOnly(top: 18.w,left: 32.w);
  //     },
  //   );
  // }

  Widget _buildItem(GamesMenuViewModel model, double opacity, GestureTapCallback tap, bool arrowVisible) {
    return Container(
      height: 35.w,
      decoration: arrowVisible ? BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]) ,
      ) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (model.image != null) Image.asset(model.image!, width: 23.w, height: 22.w,),
          SizedBox(width: 7.w,),
          if (model.title != null) Text(model.title ?? "",style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: arrowVisible ? FontWeight.w500 : FontWeight.w400)),
        ],
      ),
    )
        .opacity(arrowVisible ? 1 : 0.5)
        .onTap(() {
          tap.call();
        });
  }
}