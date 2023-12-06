import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/activity/activity_page.dart';

import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/main/binding/bindings.dart';
import 'package:kkguoji/pages/main/view/main_page.dart';
import 'package:kkguoji/pages/mine_page.dart';
import 'package:kkguoji/pages/rechange_page.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:kkguoji/utils/websocket_util.dart';

import 'generated/l10n.dart';
import '../utils/app_util.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  APPUtil();
  SqliteUtil.perInit();
  WebSocketUtil().connetSocket();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale('zh', 'CN'),
            fallbackLocale: Get.deviceLocale,
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: const AppBarTheme(color:  Color(0xFF171A26), titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              // bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xFF161D26)),
              scaffoldBackgroundColor: const Color(0xFF171A26),
              canvasColor: const Color(0xFF171A26),
              primaryColor: const Color(0xFF171A26),
              highlightColor: const Color.fromRGBO(0, 0, 0, 0),
              splashColor: const Color.fromRGBO(0, 0, 0, 0),
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
            initialBinding: mainBinding(),
            home: KKMainPage(),
          );
        });

  }
}
