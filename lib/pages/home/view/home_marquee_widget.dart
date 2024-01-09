
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:marquee/marquee.dart';

import '../logic/logic.dart';

class KKHomeMarqueeWidget extends GetView<HomeLogic> {

  final controller = Get.find<HomeLogic>();
  final String marqueeContent;
  KKHomeMarqueeWidget(this.marqueeContent, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/images/home_marquee_icon.png", width: 14, height: 14,),
          const SizedBox(width: 10,),
          if(marqueeContent.isNotEmpty)
            Expanded(child: Marquee(
              text: html2md.convert(marqueeContent),
              style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8),fontSize: 12),
              scrollAxis: Axis.horizontal, crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 10.0, velocity: 80.0,
              pauseAfterRound: const Duration(seconds: 1), startPadding: 10.0,accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,))


        ],
      ),
    );
  }
}
