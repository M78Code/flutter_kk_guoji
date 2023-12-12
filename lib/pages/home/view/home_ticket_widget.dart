import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kkguoji/pages/home/view/home_ticket_item.dart';

import '../../../model/home/jcp_game_model.dart';
import '../logic/logic.dart';

class KKHomeTicketWidget extends StatelessWidget {

  KKHomeTicketWidget({super.key});

  final controller = Get.find<HomeLogic>();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("KK游戏",
                  style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),),
                Text("KK推荐", style: TextStyle(color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),),
              ],
            ),
            Row(
              children: [
                Text("查看全部",
                  style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                SizedBox(height: 5,),
                Icon(Icons.chevron_right_outlined, size: 24,
                  color: Color(0xFFB2B3BD),)
              ],
            )
          ],
        ),
        const SizedBox(height: 15,),
        Obx(() {
          return SizedBox(
            height: 590,
            width: double.infinity,
            child: controller.margeGameList.isEmpty ? Container() : Swiper(
              autoplayDisableOnInteraction: false,
              autoplay: true,
              autoplayDelay: 5000,
              itemCount: controller.margeGameList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildGroupItem(controller.margeGameList[index]);
              },
              pagination: const SwiperPagination(),),
          );
        })
      ],
    );
  }

  Widget _buildGroupItem(List<Datum> ticketGroup) {
    return Column(
      children: List.generate(ticketGroup.length, (index) {
        Map bgInfo = controller.imageMap[ticketGroup[index].lotteryCode];
        Datum item = ticketGroup[index];
        return Column(
          children: [
            KKHomeTicketItem(bgInfo["bg_icon"], bgInfo["logo_icon"], item),
            const SizedBox(height: 30,)
          ],
        );
      }),
    );
  }
}

