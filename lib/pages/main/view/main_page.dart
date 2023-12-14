import 'package:flutter/material.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/pages/games/games_page.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/pages/recharge/recharge_page.dart';

import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';
import '../../activity/list/activity_page.dart';
import '../../home/view/home_page.dart';
<<<<<<< HEAD
import '../../mine/mine_page.dart';
=======
import '../../mine/view/mine_page.dart';
>>>>>>> eb6891a9e6f80af8a21524ab0bb59f25d14043b4

class KKMainPage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});

  // final String title;

  @override
  State<KKMainPage> createState() => _KKMainPageState();
}

class _KKMainPageState extends State<KKMainPage> {
  // int _currentIndex = 0;
  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(
        label: "首页",
        icon: Image.asset(
          "assets/images/tabbar_home_normal.png",
          width: 35,
          height: 35,
        ),
        activeIcon: Image.asset(
          "assets/images/tabbar_home_selected.png",
          width: 35,
          height: 35,
        )),
    BottomNavigationBarItem(
        label: "游戏",
        icon: Image.asset("assets/images/tabbar_games_normal.png",
            width: 35, height: 35),
        activeIcon: Image.asset("assets/images/tabbar_games_selected.png",
            width: 35, height: 35)),
    BottomNavigationBarItem(
        label: "充值",
        icon: Image.asset("assets/images/tabbar_rechange_icon.png",
            width: 35, height: 35),
        activeIcon: Image.asset("assets/images/tabbar_rechange_icon.png",
            width: 35, height: 35)),
    BottomNavigationBarItem(
        label: "活动",
        icon: Image.asset("assets/images/tabbar_activity_normal.png",
            width: 35, height: 35),
        activeIcon: Image.asset("assets/images/tabbar_activity_selected.png",
            width: 35, height: 35)),
    BottomNavigationBarItem(
        label: "我的",
        icon: Image.asset("assets/images/tabbar_mine_normal.png",
            width: 35, height: 35),
        activeIcon: Image.asset("assets/images/tabbar_mine_selected.png",
            width: 35, height: 35))
  ];
  final controller = Get.find<MainPageLogic>();

  final List _pages = [
    KKHomePage(),
    const KKGamesPage(),
    const RechargePage(),
    const ActivityPage(),
    const MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Obx(() {
        return _pages[controller.currentIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          items: _barItems,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          selectedItemColor: const Color(0xFF5D5FEF),
          unselectedItemColor: const Color(0xFF687083),
          onTap: (int index) {
            // if (index == 4) {
            //   RouteUtil.pushToView(Routes.loginPage);
            // }

            controller.clickTabBarItem(index);
          },
        );
      }),
    );
  }
}
