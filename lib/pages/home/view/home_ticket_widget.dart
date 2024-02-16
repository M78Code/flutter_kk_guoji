import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kkguoji/pages/home/view/home_ticket_item.dart';
import 'package:kkguoji/pages/home/view/home_ticket_item_new.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

import '../../../model/home/jcp_game_model.dart';
import '../../../utils/json_util.dart';
import '../../games/games_logic.dart';
import '../../main/logic/main_logic.dart';
import '../logic/logic.dart';

class KKHomeTicketWidget extends GetView<HomeLogic> {
  KKHomeTicketWidget({super.key});

  final controller = Get.find<HomeLogic>();
  final mainController = Get.find<MainPageLogic>();
  final gameController = Get.find<GamesLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/home/hotcaizhong.png',
                  width: 24,
                  height: 21,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "热门彩种",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                mainController.clickTabBarItem(1);
                gameController.switchIndex(1);
                gameController.menuOntap(1);
              },
              child: const Row(
                children: [
                  Text(
                    "查看全部",
                    style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    size: 24,
                    color: Color(0xFFB2B3BD),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(() {
          return SizedBox(
            height: 590,
            width: double.infinity,
            child: controller.margeGameList.isEmpty
                ? Container()
                :
            // Swiper(
            //         autoplayDisableOnInteraction: false,
            //         autoplay: false,
            //         autoplayDelay: 5000,
            //         itemCount: controller.margeGameList.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return _buildGroupItem(
            //               controller.margeGameList[index], index);
            //         },
            //         pagination: const SwiperPagination(),
            //       ),
            ScrollPageView(
              controller: ScrollPageController(),
              delay: const Duration(seconds: 5),
              checkedIndicatorColor: const Color(0xFF3D35C6),
              children: List.generate(controller.margeGameList.length, (index) => _buildGroupItem(controller.margeGameList[index],index)),
            ),
          );
        })
      ],
    );
  }

  Widget _buildGroupItem(List<Datum> ticketGroup, int groupIndex) {
    return Column(
      children: List.generate(ticketGroup.length, (index) {
        Map bgInfo = controller.imageMap[ticketGroup[index].lotteryCode];
        Datum item = ticketGroup[index];
        return Column(
          children: [
            KKHomeTicketItem(
              bgInfo["bg_icon"],
              bgInfo["logo_icon"],
              bgInfo["ball_color"],
              item,
              (data) => controller.gamesOnTap('JCP', data)
              // key: PageStorageKey<String>("$index"),
            ),
            // HomeTicketItemNew( bgInfo["bg_icon"],
            // bgInfo["logo_icon"],
            // bgInfo["ball_color"],groupIndex,index,(data) => controller.gamesOnTap('JCP', data)),
            const SizedBox(
              height: 15,
            )
          ],
        );
      }),
    );
  }
}
