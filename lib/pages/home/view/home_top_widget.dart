import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/utils/account_service.dart';
import 'package:kkguoji/utils/route_util.dart';

import '../../../routes/routes.dart';

class KKHomeTopWidget extends StatelessWidget {
  static var kHeight = 47.w;
  bool isLogin;

  KKHomeTopWidget(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color.fromRGBO(17, 22, 60, 1.0), Color.fromRGBO(5, 8, 32, 0.8)],
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
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: isLogin
                  ? [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 33.w,
                          height: 33.w,
                          // decoration: BoxDecoration(
                          //   color: const Color.fromRGBO(255, 255, 255, 0.2),
                          //   borderRadius: BorderRadius.circular(4),
                          // ),
                          child: Center(
                            child: TextButton(
                              style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                RouteUtil.pushToView(Routes.messageCenter);
                              },
                              child: Image.asset("assets/images/home_top_alert.png",
                                  width: 33.w, height: 33.w),
                            ),
                          )),
                    ]
                  : [
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
            )
          ],
        ),
      ),
    );
  }
}
