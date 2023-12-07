import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/games/games_logic.dart';

import '../../../generated/assets.dart';

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var i = 0; i < controller.menuList.length; i++)
              buildItem(controller.menuList[i], i == controller.currentIndex ? 1 : 0.6, () {
                controller.menuOntap(i);
              },i == controller.currentIndex).marginOnly(left: i == 0 ? 0 : 20.w),
          ],
        ).marginOnly(top: 18.w,left: 32.w);
      },
    );
  }

  GestureDetector buildItem(List<String> item, double opacity, GestureTapCallback tap, bool arrowVisible) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset(item.first, width: 44.w, height: 63.w,),
            Image.asset(item[1], width: 8.w, height: 4.w,)
                .marginOnly(top: 10.w)
                .opacity(arrowVisible ? 1 : 0),
          ],
        ).opacity(opacity),
      onTap: tap,
    );
  }
}