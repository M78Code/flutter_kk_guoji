
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/activity/activity_logic.dart';
import 'package:kkguoji/pages/activity/activity_page.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';

import '../pages/activity/activity_binding.dart';

abstract class Routes {

  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String homePage = '/home';
  static const String activity = '/activity';

  static final List<GetPage> routePage = [

    GetPage(name: loginPage, page: ()=> const KKLoginPage()),
    GetPage(name: registerPage, page: ()=> const KKRegisterPage()),
    GetPage(name: homePage, page: ()=> KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: ()=> ActivityPage(), binding: ActivityBinding())
  ];
}