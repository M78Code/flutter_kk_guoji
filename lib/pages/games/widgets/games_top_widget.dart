import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../../generated/assets.dart';

class KKGamesTopWidget extends StatelessWidget {
  const KKGamesTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(Assets.imagesHomeTopLogo, width: 115.w, height: 30.w,).marginOnly(left: 12.w),
          Obx(() {
            return Row(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "¥",
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: UserService.to.userMoneyModel?.betMoney ?? "0.00",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                )).marginOnly(right: 14.sp),
                Image.asset(Assets.gamesGamesCurrenceCn, width: 33.sp, height: 33.sp,).marginOnly(right: 12.w),
              ],
            );
          })
        ],
      ),
    );
  }
}
