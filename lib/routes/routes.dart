
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/customer/binding/bindings.dart';
import 'package:kkguoji/pages/customer/view/customer_service_page.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/promotion/binding/promotion_bindings.dart';
import 'package:kkguoji/pages/promotion/view/promotion_page.dart';
import 'package:kkguoji/pages/rebate/bindings/binding.dart';
import 'package:kkguoji/pages/rebate/logic/logic.dart';
import 'package:kkguoji/pages/rebate/view/rebate_page.dart';
import 'package:kkguoji/pages/webView/webView_page.dart';

import '../pages/activity/detail/binding.dart';
import '../pages/activity/detail/view.dart';
import '../pages/activity/list/activity_binding.dart';
import '../pages/activity/list/activity_page.dart';
import '../pages/promotion/history/view/history_records_page.dart';

abstract class Routes {

  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String homePage = '/home';
  static const String activity = '/activity';
  static const String activityDetail = "/activityDetail";
  static const String webView = "/webView";
  static const String customer = "/customer";
  static const String promotion = "/promotion";
  static const String promation_history = '/promotion_history';
  static const String rebate = '/rebate';

  static final List<GetPage> routePage = [

    GetPage(name: loginPage, page: ()=> const KKLoginPage()),
    GetPage(name: registerPage, page: ()=> const KKRegisterPage()),
    GetPage(name: homePage, page: ()=> KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: ()=> const ActivityPage(), binding: ActivityBinding()),
    GetPage(name: activityDetail, page: () => ActivityDetailPage(), binding: ActivityDetailBinding()),
    GetPage(name: webView, page:() => const KKWebViewPage()),
    GetPage(name: customer, page: () => KKCustomerServicePage(), binding: CustomerBinding()),
    GetPage(name: promotion, page: () => const KKPromotionPage(), binding: PromotionBinding()),
    GetPage(name: promation_history, page: () => const KKHistoryRecordsPage()),
    GetPage(name: rebate, page: ()=> KKRebatePage(), binding: KKRebateBinding()),


  ];
}