import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/generated/assets.dart';

import '../logic.dart';

final GlobalKey menuButtonKey1 = GlobalKey();
final GlobalKey menuButtonKey2 = GlobalKey();

class BetListMenuWidget extends StatelessWidget {
  const BetListMenuWidget({
    super.key,
    required this.menuTexts,
    required this.onTap,
  });

  final void Function(int index) onTap;
  final List<String> menuTexts;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildButton(0, this.menuTexts.first).onTap(() {
              onTap.call(0);
            }),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _buildButton(1, this.menuTexts[1]).onTap(() {
              onTap.call(1);
            }),
          )
        ],
      ),
    );
  }

  Container _buildButton(int index, String value) {
    return Container(
        key: index == 0 ? menuButtonKey1 : menuButtonKey2,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        height: 42.w,
        decoration: BoxDecoration(
          color: Color(0xFF222633),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: TextStyle(color: Color(0xFF707A8C), fontSize: 12.sp, fontWeight: FontWeight.w400),),
            GetBuilder<BetListController>(
              id: index == 0 ? "pop_arrow_1" :  "pop_arrow_2",
              builder: (controller){
                if (index == 0) {
                  return controller.isMenuPopShowing ? Image.asset(Assets.mineBetListUp, width: 16.w, height: 16.w) :  Image.asset(Assets.mineBetListDown, width: 16.w, height: 16.w);
                }
                return controller.isGamePopShowing ? Image.asset(Assets.mineBetListUp, width: 16.w, height: 16.w) :  Image.asset(Assets.mineBetListDown, width: 16.w, height: 16.w);
              },
            )
          ],
        )
    );
  }
}