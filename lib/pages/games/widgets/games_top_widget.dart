import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';

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
            if (UserService.to.isLogin == false) {
              return Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 67,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: TextButton(style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                          onPressed: (){
                            RouteUtil.pushToView(Routes.loginPage);
                          },child: const Text("登录",  style: TextStyle(color: Colors.white, fontSize: 13),)),
                      )
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    width: 67,
                    height: 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color.fromRGBO(108, 79, 224, 0.6),
                            Color.fromRGBO(63, 54, 199, 0.6),
                            Color.fromRGBO(131, 67, 212, 0.6),
                            Color.fromRGBO(143, 79, 224, 0.6)],
                        )
                    ),
                    child:  TextButton(style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                      onPressed: (){
                        RouteUtil.pushToView(Routes.registerPage);
                      },child: const Text("注册", style: TextStyle(color: Colors.white, fontSize: 14),)),
                  ),
                  SizedBox(width: 10.w,)
                ],
              );
            }
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
