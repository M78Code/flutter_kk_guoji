import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kkguoji/pages/home/view/home_ticket_item.dart';

import '../../../model/home/jcp_game_model.dart';
import '../../../utils/json_util.dart';
import '../logic/logic.dart';

class KKHomeTicketWidget extends StatelessWidget {

  KKHomeTicketWidget({super.key});

  final controller = Get.find<HomeLogic>();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/home/hotcaizhong.png',width: 24,height: 21,),
                SizedBox(width: 5,),
                Text("热门彩种", style: TextStyle(color: Colors.white,
                    fontSize: 16,
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
              autoplay: false,
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
        print('xiaoan 合并数据结果：${JsonUtil.encodeObj(item)}');
        return Column(
          children: [
            KKHomeTicketItem(bgInfo["bg_icon"], bgInfo["logo_icon"], bgInfo["ball_color"], item, (data) => controller.gamesOnTap('JCP',data)),
            const SizedBox(height: 15,)
          ],
        );
      }),
    );
  }
}

