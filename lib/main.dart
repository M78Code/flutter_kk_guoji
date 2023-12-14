import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/binding/bindings.dart';
import 'package:kkguoji/pages/main/view/main_page.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/websocket_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'generated/l10n.dart';
import '../utils/app_util.dart';
import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  APPUtil();
  // SqliteUtil();
  WebSocketUtil().connetSocket();
  await Global.init();
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
          return RefreshConfiguration(
            headerBuilder: () => const ClassicHeader(), // 自定义刷新头部
            footerBuilder: () => const ClassicFooter(), // 自定义刷新尾部
            hideFooterWhenNotFull: true, // 当列表不满一页时,是否隐藏刷新尾部
            headerTriggerDistance: 80, // 触发刷新的距离
            maxOverScrollExtent: 100, // 最大的拖动距离
            footerTriggerDistance: 150, // 触发加载的距离
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              locale: const Locale('zh', 'CN'),
              fallbackLocale: Get.deviceLocale,
              theme: ThemeData(
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                    color: Color(0xFF171A26),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
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
            ),
          );
        });
  }
}
