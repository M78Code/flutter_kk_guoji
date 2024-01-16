import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/main/binding/bindings.dart';
import 'package:kkguoji/pages/main/view/main_page.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/config_service.dart';

import 'custom_route_observer.dart';
import 'generated/assets.dart';
import 'generated/l10n.dart';
import '../utils/app_util.dart';
import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  APPUtil();
  // SqliteUtil();
  await Global.init();
  await FlutterUserAgent.init();
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
            home: const KKMainPage(),
            navigatorObservers: [CustomRouteObserver()],
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  Obx(() => Visibility(
                    visible: ConfigService.to.isSupportIconVisible.value,
                    child: Positioned(
                      bottom: 90.w,
                      right: 20.w,
                      child: SizedBox(width: 46.w, height: 46.w, child: Image.asset(Assets.gamesSupport)).onTap(() {
                        // RouteUtil.pushToView(Routes.customer);
                        Get.toNamed(Routes.customer);
                      }),
                    ),
                  )),
                ],
              );
            },
          );
        });
  }
}

