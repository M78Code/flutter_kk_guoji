import 'package:flutter/material.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/games/games_page.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/pages/recharge/recharge_page.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import '../../activity/list/activity_page.dart';
import '../../home/view/home_page.dart';
import '../../mine/mine_page.dart';

class KKMainPage extends StatefulWidget {
  const KKMainPage({super.key});

  // const MyHomePage({super.key, required this.title});

  // final String title;

  @override
  State<KKMainPage> createState() => _KKMainPageState();
}

class _KKMainPageState extends State<KKMainPage> {
  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(
        label: "首页",
        icon: Image.asset(
          Assets.imagesTabbarHomeNormal,
          width: 35,
          height: 35,
        ),
        activeIcon: Image.asset(
          Assets.imagesTabbarHomeSelected,
          width: 35,
          height: 35,
        )),
    BottomNavigationBarItem(
      label: "游戏",
      icon: Image.asset(Assets.imagesTabbarGamesNormal, width: 35, height: 35),
      activeIcon: Image.asset(Assets.imagesTabbarGamesSelected, width: 35, height: 35),
    ),
    BottomNavigationBarItem(
      label: "充值",
      icon: Image.asset(Assets.imagesTabbarRechangeIcon, width: 35, height: 35),
      activeIcon: Image.asset(Assets.imagesTabbarRechangeIcon, width: 35, height: 35),
    ),
    BottomNavigationBarItem(
      label: "活动",
      icon: Image.asset(Assets.imagesTabbarActivityNormal, width: 35, height: 35),
      activeIcon: Image.asset(Assets.imagesTabbarActivitySelected, width: 35, height: 35),
    ),
    BottomNavigationBarItem(
      label: "我的",
      icon: Image.asset(Assets.imagesTabbarMineNormal, width: 35, height: 35),
      activeIcon: Image.asset(Assets.imagesTabbarMineSelected, width: 35, height: 35),
    )
  ];
  final controller = Get.find<MainPageLogic>();
  final userService = Get.find<UserService>();

  final List<Widget> _pages = [const KKHomePage(), const KKGamesPage(), const RechargePage(), const ActivityPage(), MinePage()];

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
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _barItems,
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF5D5FEF),
        unselectedItemColor: const Color(0xFF687083),
        onTap: (int index) {
          if (userService.isLogin == false) {
            if (index != 0 && index != 1) {
              RouteUtil.pushToView(Routes.loginPage);
              return;
            }
          }
          // controller.clickTabBarItem(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  final homePage = const KKHomePage();
  final gamePage = const KKGamesPage();
  final rechargePage = const RechargePage();
  final activityPage = const ActivityPage();
  final minePage =  MinePage();

  Widget getPageOnSelectedMenu(int index) {
    switch (index) {
      case 0:
        return homePage;
      case 1:
        return gamePage;
      case 2:
        return rechargePage;
      case 3:
        return activityPage;
      case 4:
        return minePage;
      default:
        return homePage;
    }
  }
}
