
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';

abstract class Routes {

  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String homePage = '/home';

  static final List<GetPage> routePage = [

    GetPage(name: loginPage, page: ()=> const KKLoginPage(),transition: Transition.downToUp),
    GetPage(name: registerPage, page: ()=> const KKRegisterPage(), transition: Transition.downToUp),
    GetPage(name: homePage, page: ()=> KKHomePage(), binding: HomeBinding())
  ];
}