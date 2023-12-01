
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class KKHomeMarqueeWidget extends StatelessWidget {
  const KKHomeMarqueeWidget({super.key});

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
          Expanded(child: Marquee(
            text: "与可靠国际一同探索无尽乐趣，每一天都是一场盛大的娱乐!",
            style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.8),fontSize: 12),
            scrollAxis: Axis.horizontal, crossAxisAlignment: CrossAxisAlignment.center,
            blankSpace: 10.0, velocity: 80.0,
            pauseAfterRound: const Duration(seconds: 1), startPadding: 10.0,accelerationDuration: const Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,)
          )

        ],
      ),
    );
  }
}
