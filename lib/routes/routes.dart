
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/mine/wallet/index/wallet_page.dart';
import 'package:kkguoji/pages/webView/webView_page.dart';

import '../pages/activity/detail/binding.dart';
import '../pages/activity/detail/view.dart';
import '../pages/activity/list/activity_binding.dart';
import '../pages/activity/list/activity_page.dart';
import '../pages/mine/wallet/wallet_fund_detail/view.dart';
import '../pages/mine/wallet/wallet_record/view.dart';

abstract class Routes {

  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String homePage = '/home';
  static const String activity = '/activity';
  static const String activityDetail = "/activityDetail";
  static const String webView = "/webView";
  static const String walletPage = "/walletPage";
  static const String walletFundDetailPage = "/walletFundDetailPage";
  static const String walletRecordPage = "/walletRecordPage";

  static final List<GetPage> routePage = [

    GetPage(name: loginPage, page: ()=> const KKLoginPage()),
    GetPage(name: registerPage, page: ()=> const KKRegisterPage()),
    GetPage(name: homePage, page: ()=> KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: ()=> ActivityPage(), binding: ActivityBinding()),
    GetPage(name: activityDetail, page: () => ActivityDetailPage(), binding: ActivityDetailBinding()),
    GetPage(name: webView, page:() => KKWebViewPage()),
    GetPage(name: walletPage, page:() => WalletPage()),
    GetPage(name: walletFundDetailPage, page:() => WalletFundDetailPage()),
    GetPage(name: walletRecordPage, page:() => WalletRecordPage()),
  ];
}