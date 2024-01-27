import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';

import '../../../generated/assets.dart';

class KKHomeBalanceWidget extends StatefulWidget {
  const KKHomeBalanceWidget({super.key});

  @override
  State<StatefulWidget> createState() => _KKHomeBalanceState();

}

class _KKHomeBalanceState extends State<KKHomeBalanceWidget> with SingleTickerProviderStateMixin,WidgetsBindingObserver{
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  final userService = Get.find<UserService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 720.0,
    ).animate(_controller);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('刷新金额1');
    // 当应用回到前台时
    if (state == AppLifecycleState.resumed) {
      print('刷新金额2');
      userService.fetchUserMoney();
    }
  }

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
                return userService.userInfoModel.value == null? GestureDetector(
                  child: const Text(
                    "请登录",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: (){
                    RouteUtil.pushToView(Routes.loginPage);
                  },
                ):Text(userService.userInfoModel.value!.userNick!,style: const TextStyle(color: Colors.white, fontSize: 14),);
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
                          UserService.to.userMoneyModel?.money ?? "0.00",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, fontFamily: "DINPro-Bold"),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        userService.fetchUserMoney();
                        _controller.reset();
                        _controller.forward();
                        final service = UserService.to;
                        service.fetchUserMoney().then((value) => service.fetchUserInfo());
                      },
                      style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value * (3.14 / 180), // 将度数转换为弧度
                            child: Image.asset(
                              Assets.imagesHomeRefreshIcon,
                              width: 18,
                              height: 18,
                              fit: BoxFit.fitWidth,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(width: 80),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.homeChongzhi,
                          width: 31,
                          height: 26,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "充值",
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                          Assets.homeTixian,
                          width: 31,
                          height: 27,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "提现",
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 29,
                              height: 25,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(1.00, 0.00),
                                  end: Alignment(-1, 0),
                                  colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                            Image.asset(
                              Assets.homeZhudanIcon,
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        // Image.asset(
                        //   Assets.imagesHomeDanzhuIcon,
                        //   width: 31,
                        //   height: 26,
                        //   fit: BoxFit.contain,
                        // ),
                        const SizedBox(height: 7),
                        const Text(
                          "注单",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                    onTap: (){
                      RouteUtil.pushToView(Routes.betListPage);
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }

}
