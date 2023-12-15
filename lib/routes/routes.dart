import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/email/bind_email_page.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/customer/binding/bindings.dart';
import 'package:kkguoji/pages/customer/view/customer_service_page.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/mine/wallet/index/wallet_page.dart';
import 'package:kkguoji/pages/mine/message/message.dart';
import 'package:kkguoji/pages/mine/mine_page.dart';
import 'package:kkguoji/pages/mine/setting/setting.dart';
import 'package:kkguoji/pages/promotion/binding/promotion_bindings.dart';
import 'package:kkguoji/pages/promotion/view/promotion_page.dart';
import 'package:kkguoji/pages/rebate/bindings/binding.dart';
import 'package:kkguoji/pages/rebate/view/rebate_page.dart';
import 'package:kkguoji/pages/recharge/recharge_page.dart';
import 'package:kkguoji/pages/webView/webView_page.dart';
import 'package:kkguoji/pages/withdraw/withdraw_page.dart';
import 'package:kkguoji/services/user_service.dart';
import '../pages/activity/detail/binding.dart';
import '../pages/activity/detail/view.dart';
import '../pages/activity/list/activity_binding.dart';
import '../pages/activity/list/activity_page.dart';
import '../pages/mine/wallet/wallet_fund_detail/view.dart';
import '../pages/mine/wallet/wallet_record/view.dart';
import '../pages/promotion/history/view/history_records_page.dart';

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
  static const String customer = "/customer";
  static const String promotion = "/promotion";
  static const String promation_history = '/promotion_history';
  static const String rebate = '/rebate';
  static const String recharge = "/recharge";
  static const String withdraw = "/withdraw";
  static const String bindEmail = "/account/email";
  static const String mine = "/mine";
  static const String messageCenter = '/mine/message'; //公告信息查询
  static const String settingPage = "/mine/setting";

  static final List<GetPage> routePage = [
    GetPage(name: messageCenter, page: () => const MessageCenterPage()),
    GetPage(name: bindEmail, page: () => const BindEmailPage()),
    GetPage(name: mine, page: () => const MinePage()),
    GetPage(name: settingPage, page: () => const SettingPage()),
    GetPage(name: loginPage, page: () => const KKLoginPage()),
    GetPage(name: registerPage, page: () => const KKRegisterPage()),
    GetPage(name: homePage, page: () => KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: () => const ActivityPage(), binding: ActivityBinding()),
    GetPage(name: activityDetail, page: () => getPage(activityDetail), binding: ActivityDetailBinding()),
    GetPage(name: webView, page:() => KKWebViewPage()),
    GetPage(name: walletPage, page:() => WalletPage()),
    GetPage(name: walletFundDetailPage, page:() => WalletFundDetailPage()),
    GetPage(name: walletRecordPage, page:() => WalletRecordPage()),
    GetPage(name: webView, page: () => const KKWebViewPage()),
    GetPage(name: customer, page: () => KKCustomerServicePage(), binding: CustomerBinding()),
    GetPage(name: promotion, page: () => const KKPromotionPage(), binding: PromotionBinding()),
    GetPage(name: promation_history, page: () => const KKHistoryRecordsPage()),
    GetPage(name: rebate, page: () => KKRebatePage(), binding: KKRebateBinding()),
    // GetPage(name: recharge, page: () => getPage(recharge)),
    // GetPage(name: withdraw, page: () => getPage(withdraw)),
  ];


  static Widget getPage(String pageName) {
    if(!Get.find<UserService>().isLogin) {
      return const KKLoginPage();
    }else {
      if(pageName == activityDetail) {
        return ActivityDetailPage();
      } else if (pageName == withdraw) {
        return const WithdrawPage();
      }else if (pageName == recharge) {
        return const RechargePage();
      }
      
      else {
        return Container();
      }
    }
  }

}
