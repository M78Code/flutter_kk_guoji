import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';
import 'package:kkguoji/pages/home/view/home_balance_widget.dart';
import 'package:kkguoji/pages/home/view/home_games_widget.dart';
import 'package:kkguoji/pages/home/view/home_marquee_widget.dart';
import 'package:kkguoji/pages/home/view/home_real_widget.dart';
import 'package:kkguoji/pages/home/view/home_sports_widget.dart';
import 'package:kkguoji/pages/home/view/home_ticket_widget.dart';
import 'package:kkguoji/pages/home/view/home_top_widget.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:lottie/lottie.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';
import 'home_serve_widget.dart';

class KKHomePage extends StatefulWidget {
  const KKHomePage({super.key});

  @override
  _KKHomeViewState createState() => _KKHomeViewState();
}

/// Page - State with AutomaticKeepAliveClientMixin
class _KKHomeViewState extends State<KKHomePage> with AutomaticKeepAliveClientMixin,RouteAware,WidgetsBindingObserver {
  final controller = Get.find<HomeLogic>();
  final globalController = Get.find<UserService>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didPopNext() {
    controller.getTicketList();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    print('重置页面');
    super.build(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // ScrollPageView(controller: controller),
            Container(
              color: const Color(0xFF171A26),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  child: Column(
                    children: [
                      Obx(() {
                        return Container(
                          height: 160.w,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 12.w, right: 12.w, top: KKHomeTopWidget.kHeight + 6.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.w),
                            child: Swiper(
                                autoplayDisableOnInteraction: false,
                                itemCount: controller.bannerItemCount.value,
                                itemBuilder: (BuildContext context, int index) {
                                  Map bannerInfo = controller.bannerList[index];
                                  // if (bannerInfo.isNotEmpty) {
                                  //   return Image.network(bannerInfo["image"], fit: BoxFit.cover);
                                  // } else {
                                  //   return Container();
                                  // }
                                  return GestureDetector(
                                    onTap: (){
                                      String link = bannerInfo["link"].toString();
                                      if(link.isNotEmpty) {
                                        RouteUtil.pushToView(Routes.webView, arguments: link);
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:bannerInfo["image"],
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        // Handle the error by displaying a default image or an error icon.
                                        return Image.asset(
                                          Assets.homeDefalutBanner, // Replace with your default image asset
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  );
                                },
                                pagination: controller.bannerItemCount.value==0?null:const SwiperPagination(
                                  builder: DotSwiperPaginationBuilder(
                                    activeColor: Color(0xFF6C4FE0), // 选中的圆点颜色
                                    color: Color(0xFFFFF3F3), // 未选中的圆点颜色
                                  ),
                                ),
                            controller: controller.swiperController,),
                          ),
                        );
                      }),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            Obx(
                              () => KKHomeMarqueeWidget(controller.marqueeStr.value,controller.winGameList),
                            ),
                            //余额 存款 取款
                            KKHomeBalanceWidget(),

                            KKHomeGamesWidget(),

                            KKHomeTicketWidget(),

                            KKHomeSportsWidget(),

                            KKHomeRealWidget(),

                            HomeServeWidget(),

                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Positioned(
              child: Obx(() {
                return KKHomeTopWidget(globalController.isLogin);
              }),
            ),
            Positioned(
                bottom: 150,
                right: 10,
                child: InkWell(
                  onTap: (){
                    RouteUtil.pushToView(Routes.tutorialPage);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(Assets.homeUjc),
                  ),
                )),
          ],
        ),
      ),
    ).safeArea();
  }

}
