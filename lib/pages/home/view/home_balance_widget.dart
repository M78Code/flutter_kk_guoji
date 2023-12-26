import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';

import '../../../generated/assets.dart';

class KKHomeBalanceWidget extends StatelessWidget {
  KKHomeBalanceWidget({super.key});

  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E374C), Color(0xFF181E2F)],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Text(
                  userService.userInfoModel.value == null ? "请登录" : userService.userInfoModel.value!.userNick!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                );
              }),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      "¥${userService.userInfoModel.value?.money ?? 0.0}",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, fontFamily: "DINPro-Bold"),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        final service = UserService.to;
                        service.fetchUserMoney().then((value) => service.fetchUserInfo());
                      },
                      style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: Image.asset(
                        Assets.imagesHomeRefreshIcon,
                        width: 18,
                        height: 18,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesHomeCunkuanIcon,
                      width: 27,
                      height: 25,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "充值",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                onTap: () {
                  RouteUtil.pushToView(Routes.recharge, arguments: true);
                },
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesHomeQukuanIcon,
                      width: 27,
                      height: 25,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "提现",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                onTap: () {
                  RouteUtil.pushToView(Routes.withdraw, arguments: true);
                },
              ),
              // GestureDetector(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         Assets.imagesHomeVipIcon,
              //         width: 27,
              //         height: 25,
              //       ),
              //       const SizedBox(height: 10),
              //       const Text(
              //         "VIP",
              //         style: TextStyle(color: Colors.white, fontSize: 16),
              //       )
              //     ],
              //   ),
              // ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.imagesHomeDanzhuIcon,
                      width: 27,
                      height: 25,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "注单",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
