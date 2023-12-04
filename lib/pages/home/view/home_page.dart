import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';
import 'package:kkguoji/pages/home/view/home_balance_widget.dart';
import 'package:kkguoji/pages/home/view/home_games_widget.dart';
import 'package:kkguoji/pages/home/view/home_marquee_widget.dart';
import 'package:kkguoji/pages/home/view/home_real_widget.dart';
import 'package:kkguoji/pages/home/view/home_sports_widget.dart';
import 'package:kkguoji/pages/home/view/home_ticket_widget.dart';
import 'package:kkguoji/pages/home/view/home_top_widget.dart';

class KKHomePage extends GetView<HomeLogic> {


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeLogic>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF171A26),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: Swiper(
                        autoplayDisableOnInteraction:false,
                        autoplay: true,
                        itemCount: controller.bannerList.length, itemBuilder: (BuildContext context, int index) {
                        Map bannerInfo = controller.bannerList.value[index];
                        if(bannerInfo.isNotEmpty) {
                          return Image.network(bannerInfo["image"], fit: BoxFit.cover,);
                        }else {
                          return Container();
                        }
                      },
                        pagination: const SwiperPagination(), ),
                    );
                  }),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Column(
                      children: [
                        Obx(() => KKHomeMarqueeWidget(controller.marqueeStr.value),),
                        //余额 存款 取款
                        KKHomeBalanceWidget(),

                        KKHomeGamesWidget(),

                        Obx(() => KKHomeTicketWidget(controller.ticketList.value)),

                        KKHomeRealWidget(),

                        KKHomeSportsWidget(),
                        // Container(
                        //   height: 83,
                        //   width: double.infinity,
                        //   padding: const EdgeInsets.only(left: 15),
                        //   decoration: BoxDecoration(
                        //     gradient: const LinearGradient(
                        //       colors: [Color(0xFF2E374C), Color(0xFF181E2F)],
                        //     ),
                        //     borderRadius: BorderRadius.circular(6),
                        //   ),
                        //   child:  Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //
                        //           const Text("请登录", style: TextStyle(color: Colors.white, fontSize: 13),),
                        //
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               const Text("\$0.00", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
                        //               SizedBox(
                        //                 width: 30,
                        //                 height: 30,
                        //                 child: TextButton(onPressed: (){
                        //
                        //                 },
                        //                   style: const ButtonStyle(
                        //                       padding: MaterialStatePropertyAll(EdgeInsets.zero)
                        //                   ),
                        //                   child: Image.asset("assets/images/home_refresh_icon.png",width: 18, height: 18,fit: BoxFit.fitWidth,),
                        //                 ),
                        //               )
                        //
                        //             ],
                        //           )
                        //
                        //         ],
                        //       ),
                        //       const SizedBox(width:30,),
                        //       Expanded(child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           GestureDetector(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Image.asset("assets/images/home_cunkuan_icon.png", width: 27, height: 25,),
                        //                 const SizedBox(height: 10,),
                        //                 const Text("存款", style: TextStyle(color: Colors.white, fontSize: 16),)
                        //               ],
                        //             ),
                        //           ),
                        //           GestureDetector(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Image.asset("assets/images/home_qukuan_icon.png", width: 27, height: 25,),
                        //                 const SizedBox(height: 10,),
                        //                 const Text("取款", style: TextStyle(color: Colors.white, fontSize: 16),)
                        //               ],
                        //             ),
                        //           ),
                        //           GestureDetector(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Image.asset("assets/images/home_vip_icon.png", width: 27, height: 25,),
                        //                 const SizedBox(height: 10,),
                        //                 const Text("VIP", style: TextStyle(color: Colors.white, fontSize: 16),)
                        //               ],
                        //             ),
                        //           ),
                        //           GestureDetector(
                        //             child: Column(
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Image.asset("assets/images/home_danzhu_icon.png", width: 27, height: 25,),
                        //                 const SizedBox(height: 10,),
                        //                 const Text("单住", style: TextStyle(color: Colors.white, fontSize: 16),)
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ))
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  )

                ],
              )
            ),
          ),
          const Positioned(child:KKHomeTopWidget(),),
        ],
      ),
    );
  }
}
