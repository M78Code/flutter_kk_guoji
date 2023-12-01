import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/activity_page.dart';
import 'package:kkguoji/pages/games_page.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/mine_page.dart';
import 'package:kkguoji/pages/rechange_page.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

import 'generated/l10n.dart';
import '../utils/app_util.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    APPUtil();
    SqliteUtil.perInit();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('zh', 'CN'),
      fallbackLocale: Get.deviceLocale,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color:  Color(0xFF171A26), titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xFF161D26)),
        scaffoldBackgroundColor: const Color(0xFF171A26),
        canvasColor: const Color(0xFF171A26),
        primaryColor: const Color(0xFF171A26)
      ),
      defaultTransition: Transition.cupertino,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      getPages: Routes.routePage,
      home: const KKHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  int _currentIndex = 0;
  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem( label:"首页",icon: Image.asset("assets/images/tabbar_home_normal.png",width: 35, height: 35,), activeIcon: Image.asset("assets/images/tabbar_home_selected.png", width: 35, height: 35,)),
    BottomNavigationBarItem( label:"游戏",icon: Image.asset("assets/images/tabbar_games_normal.png",width: 35, height: 35), activeIcon: Image.asset("assets/images/tabbar_games_selected.png",width: 35, height: 35)),
    BottomNavigationBarItem( label:"充值",icon: Image.asset("assets/images/tabbar_rechange_icon.png",width: 35, height: 35), activeIcon: Image.asset("assets/images/tabbar_rechange_icon.png",width: 35, height: 35)),
    BottomNavigationBarItem( label:"活动",icon: Image.asset("assets/images/tabbar_activity_normal.png",width: 35, height: 35), activeIcon: Image.asset("assets/images/tabbar_activity_selected.png",width: 35, height: 35)),
    BottomNavigationBarItem( label:"我的",icon: Image.asset("assets/images/tabbar_mine_normal.png",width: 35, height: 35), activeIcon: Image.asset("assets/images/tabbar_mine_selected.png",width: 35, height: 35))
  ];

  final List _pages = [const KKHomePage(), const GamesPage(), const RechangePage(),const ActivityPage(),const MinePage()];

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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _barItems,
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        // selectedIconTheme:const IconThemeData(
        //   size: 35
        // ),
        // unselectedIconTheme: const IconThemeData(
        //   size: 35
        // ),
        currentIndex: _currentIndex,
        selectedLabelStyle: _currentIndex == 2?  const TextStyle(color: Color(0xFFFF8A00), fontSize: 16): const TextStyle(color: Color(0xFF5D5FEF),fontSize: 16),
        unselectedLabelStyle: _currentIndex == 2?  const TextStyle(color: Color(0xFFFF8A00),fontSize: 16): const TextStyle(color: Color(0xFF687083),fontSize: 16),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
  }
}
