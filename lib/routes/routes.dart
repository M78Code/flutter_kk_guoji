import 'package:get/get.dart';
import 'package:kkguoji/pages/account/email/bind_email_page.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/recharge/recharge_page.dart';
import 'package:kkguoji/pages/message/message.dart';
import 'package:kkguoji/pages/webView/webView_page.dart';
import 'package:kkguoji/pages/withdraw/withdraw_page.dart';
import '../pages/activity/detail/binding.dart';
import '../pages/activity/detail/view.dart';
import '../pages/activity/list/activity_binding.dart';
import '../pages/activity/list/activity_page.dart';

abstract class Routes {
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String homePage = '/home';
  static const String activity = '/activity';
  static const String activityDetail = "/activityDetail";
  static const String webView = "/webView";
  static const String recharge = "/recharge";
  static const String withdraw = "/withdraw";
  static const String getMessageList = '/notice/list'; //公告信息查询
  static const String bindEmail = "/account/email";

  static final List<GetPage> routePage = [
    GetPage(name: loginPage, page: () => const KKLoginPage()),
    GetPage(name: registerPage, page: () => const KKRegisterPage()),
    GetPage(name: homePage, page: () => KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: () => const ActivityPage(), binding: ActivityBinding()),
    GetPage(name: activityDetail, page: () => ActivityDetailPage(), binding: ActivityDetailBinding()),
    GetPage(name: webView, page: () => KKWebViewPage()),
    GetPage(name: recharge, page: () => const RechargePage()),
    GetPage(name: withdraw, page: () => const WithdrawPage()),
    GetPage(name: getMessageList, page: () => MessageCenterPage()),
    GetPage(name: bindEmail, page: () => const BindEmailPage()),
  ];
}
