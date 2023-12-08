
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/logic.dart';
import 'home_ticket_item.dart';
class KKHomeTicketGroupItem extends StatelessWidget {
  final List ticketGroup;
  KKHomeTicketGroupItem(this.ticketGroup,{super.key});
  final controller = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ticketGroup.asMap().entries.map((e) {
        Map ticketInfo = e.value;
        Map bgInfo = controller.imageMap[ticketInfo["lotteryCode"]];
        Map playInfo = ticketInfo["play"];
        List playList = playInfo["cachePlayList"] ?? playInfo["lotteryPlayTypeList"];
        Map? info = controller.ticketInfo.value;
        if(info.isNotEmpty) {
          if(info!["lotteryCode"] != ticketInfo["lotteryCode"]) {
            info = null;
          }else {

          }
        }else {
          info = null;
        }
        return Container();
      }).toList(),
    );
  }
}
