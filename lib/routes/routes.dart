import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/email/bind_email_page.dart';
import 'package:kkguoji/pages/account/login/view.dart';
import 'package:kkguoji/pages/account/register/view.dart';
import 'package:kkguoji/pages/customer/binding/bindings.dart';
import 'package:kkguoji/pages/customer/view/customer_service_page.dart';
import 'package:kkguoji/pages/games/games_page.dart';
import 'package:kkguoji/pages/home/binding/bindings.dart';
import 'package:kkguoji/pages/home/view/home_page.dart';
import 'package:kkguoji/pages/main/view/main_page.dart';
import 'package:kkguoji/pages/mine/data/personal_data_page.dart';
import 'package:kkguoji/pages/mine/bet_list/view.dart';
import 'package:kkguoji/pages/mine/myaccount/page/switch_avatar_page.dart';
import 'package:kkguoji/pages/mine/myaccount/page/set_login_psd_page.dart';
import 'package:kkguoji/pages/mine/wallet/index/wallet_page.dart';
import 'package:kkguoji/pages/mine/message/message.dart';
import 'package:kkguoji/pages/mine/mine_page.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_page.dart';
import 'package:kkguoji/pages/mine/setting/setting.dart';
import 'package:kkguoji/pages/promotion/binding/promotion_bindings.dart';
import 'package:kkguoji/pages/promotion/view/promotion_page.dart';
import 'package:kkguoji/pages/rebate/bindings/binding.dart';
import 'package:kkguoji/pages/rebate/view/rebate_page.dart';
import 'package:kkguoji/pages/recharge/recharge_page.dart';
import 'package:kkguoji/pages/webView/provicy_webView.dart';
import 'package:kkguoji/pages/webView/webView_page.dart';
import 'package:kkguoji/pages/withdraw/withdraw_page.dart';
import 'package:kkguoji/services/user_service.dart';
import '../pages/activity/detail/binding.dart';
import '../pages/activity/detail/view.dart';
import '../pages/activity/list/activity_binding.dart';
import '../pages/activity/list/activity_page.dart';
import '../pages/award/binding.dart';
import '../pages/award/view.dart';
import '../pages/mine/claimrecord/claim_record_page.dart';
import '../pages/mine/data/person_data_building.dart';
import '../pages/mine/information_settings/view.dart';
import '../pages/mine/wallet/wallet_fund_detail/view.dart';
import '../pages/mine/wallet/wallet_record/view.dart';
import '../pages/promotion/history/view/history_records_page.dart';
import '../pages/webView/tg_webview.dart';
import '../pages/withdraw/withdraw_psd_page.dart';

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
  static const String withdrawPsd = "/withdrawPsd";
  static const String bindEmail = "/account/email";
  static const String mine = "/mine";
  static const String game = "/games";
  static const String messageCenter = '/mine/message'; //公告信息查询
  static const String settingPage = "/mine/setting";
  static const String claimRecordPage = "/mine/claimrecord"; //领取记录
  static const String personalData = "/personDataPage";
  static const String betListPage = "/betListPage";
  static const String personalInfoPage = "/mine/personalInfoPage";
  static const String myAccountPage = "/mine/myaccount";
  static const String setLoginPsdPage = "/mine/setLoginPsdPage";
  static const String mainPage = "/main/view/mainPage";
  static const String informationSettingsPage = "/mine/informationSettingsPage";
  static const String tgWebView = "/tg_webview";
  static const String awardPage = "/award_page";
  static const String privacyPage = "/privacyPage";

  static final List<GetPage> routePage = [
    GetPage(name: loginPage, page: () => const KKLoginPage()),
    GetPage(name: registerPage, page: () => const KKRegisterPage()),
    GetPage(name: homePage, page: () => KKHomePage(), binding: HomeBinding()),
    GetPage(name: activity, page: () => const ActivityPage(), binding: ActivityBinding()),
    GetPage(name: activityDetail, page: () => ActivityDetailPage(), binding: ActivityDetailBinding()),
    GetPage(name: walletPage, page: () => const WalletPage()),
    GetPage(name: walletFundDetailPage, page: () => const WalletFundDetailPage()),
    GetPage(name: walletRecordPage, page: () => WalletRecordPage()),
    GetPage(name: webView, page: () => const KKWebViewPage()),
    GetPage(name: customer, page: () => KKCustomerServicePage(), binding: CustomerBinding()),
    GetPage(name: promotion, page: () => const KKPromotionPage(), binding: PromotionBinding()),
    GetPage(name: promation_history, page: () => const KKHistoryRecordsPage()),
    GetPage(name: recharge, page: () => const RechargePage()),
    GetPage(name: withdraw, page: () => const WithdrawPage()),
    GetPage(name: withdrawPsd, page: () => const WithdrawPsdPage()),
    GetPage(name: claimRecordPage, page: () => const ClaimRecordPage()),
    GetPage(name: rebate, page: () => KKRebatePage(), binding: KKRebateBinding()),
    GetPage(name: personalData, page: () => KKPersonalDataPage(), binding: PersonalDataBinding()),
    GetPage(name: betListPage, page: () => const BetListPage()),
    GetPage(name: messageCenter, page: () => const MessageCenterPage()),
    GetPage(name: bindEmail, page: () => const BindEmailPage()),
    GetPage(name: mine, page: () => MinePage()),
    GetPage(name: settingPage, page: () => const SettingPage()),
    GetPage(name: personalInfoPage, page: () => const SwitchAvatarPage()),
    GetPage(name: myAccountPage, page: () => const MyAccountPage()),
    GetPage(name: setLoginPsdPage, page: () => const SetLoginPsdPage()),
    GetPage(name: mainPage, page: () => const KKMainPage()),
    GetPage(name: informationSettingsPage, page: () => const InformationSettingsPage()),
    GetPage(name: game, page: () => const KKGamesPage()),
    GetPage(name: tgWebView, page: () => TGWebview()),
    GetPage(name: awardPage, page: () => AwardPage(), binding: AwardBinding()),
    GetPage(name: privacyPage, page: ()=> const KKPrivacyPage()),
  ];

  static Widget getPage(String pageName) {
    //没有登录，跳转登录页面
    if (Get.find<UserService>().isLogin) {
      return const KKLoginPage();
    }

    if (pageName == recharge) {
      return const RechargePage();
    } else if (pageName == withdraw) {
      return const WithdrawPage();
    }

    return Container();
  }
}
