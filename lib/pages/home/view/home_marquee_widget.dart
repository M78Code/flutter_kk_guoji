import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:kkguoji/common/models/get_game_win_recent.dart';
import 'package:kkguoji/widget/custom_marquee.dart';

import '../logic/logic.dart';

class KKHomeMarqueeWidget extends GetView<HomeLogic> {
  final controller = Get.find<HomeLogic>();
  final String marqueeContent;
  List<WinGame> getGameWinList;
  KKHomeMarqueeWidget(this.marqueeContent, this.getGameWinList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/home_marquee_icon.png",
            width: 14,
            height: 14,
          ),
          const SizedBox(
            width: 10,
          ),
          if (marqueeContent.isNotEmpty)
            Expanded(
                child:  Marquee(
                  speed: 30,
                  child: Row(
                    children: [
                      Row(
                        children:
                          List.generate(getGameWinList.length, (index) {
                            return _buildRichText(getGameWinList[index]);
                          }),
                      ),
                      SizedBox(width: 10,),
                      Text(html2md.convert(marqueeContent),style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12),)
                    ],
                  ),
                ),
            //     Marquee(
            //   text: html2md.convert(marqueeContent),
            //   style: const TextStyle(
            //       color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12),
            //   scrollAxis: Axis.horizontal,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   blankSpace: 10.0,
            //   velocity: 80.0,
            //   pauseAfterRound: const Duration(seconds: 1),
            //   startPadding: 10.0,
            //   accelerationDuration: const Duration(seconds: 1),
            //   accelerationCurve: Curves.linear,
            //   decelerationDuration: const Duration(milliseconds: 500),
            //   decelerationCurve: Curves.easeOut,
            // )

            )
        ],
      ),
    );
  }

  Widget _buildRichText(WinGame bean){
    return RichText(text: TextSpan(
      children:[
        TextSpan(text: '恭喜玩家',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12)),
        TextSpan(text: '${bean.userNick.substring(0,3)}***',style: TextStyle(color: Color(0xFF831AD7), fontSize: 12)),
        TextSpan(text: '在',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12)),
        TextSpan(text: bean.gameName,style: TextStyle(color: Color(0xFFE9AC35), fontSize: 12)),
        TextSpan(text: '游戏中赢得',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12)),
        TextSpan(text: '${bean.gameProfit}',style: TextStyle(color: Color(0xFFFF5D3A), fontSize: 12)),
        TextSpan(text: '元大奖。',style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8), fontSize: 12)),
      ]
    ),
    );
  }
}
