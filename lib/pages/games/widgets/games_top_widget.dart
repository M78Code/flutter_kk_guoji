import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';

class KKGamesTopWidget extends StatelessWidget {
  static var kHeight = 47.w;
  bool isLogin;

  KKGamesTopWidget(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromRGBO(17, 22, 60, 1.0),
          Color.fromRGBO(5, 8, 32, 0.8)
        ],
      )),
      child: Container(
        padding: EdgeInsets.only(left: 17.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.imagesHomeTopLogo,
              width: 106.w,
              height: 33.w,
            ),
            Image.asset(
              Assets.homeAdIcon,
              height: 22.w,
            ),
            if (this.isLogin == false) _buildUnLogingView(),
            if (this.isLogin == true) _buildLoginView(),
          ],
        ),
      ),
    );
  }

  Row _buildLoginView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(
          children: [
            // TextSpan(
            //   text: "¥",
            //   style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.bold),
            // ),
            TextSpan(
              text: UserService.to.userMoneyModel?.money ?? "0.00",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )).marginOnly(right: 14.sp),
        // Image.asset(Assets.gamesGamesCurrenceCn, width: 33.sp, height: 33.sp,).marginOnly(right: 12.w),
      ],
    );
  }

  Widget _buildUnLogingView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 54.w,
            height: 27.w,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: TextButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: () {
                  RouteUtil.pushToView(Routes.loginPage);
                },
                child: Text(
                  "登录",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ),
            )),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 64.w,
          height: 27.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(108, 79, 224, 0.6),
                  Color.fromRGBO(63, 54, 199, 0.6),
                  Color.fromRGBO(131, 67, 212, 0.6),
                  Color.fromRGBO(143, 79, 224, 0.6)
                ],
              )),
          child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
            ),
            onPressed: () {
              RouteUtil.pushToView(Routes.registerPage);
            },
            child: Text(
              "注册",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        )
      ],
    );
  }
}
