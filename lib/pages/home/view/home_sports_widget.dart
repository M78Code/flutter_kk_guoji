import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';

class KKHomeSportsWidget extends GetView<HomeLogic> {
  KKHomeSportsWidget({super.key});

  final controller = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/home/sportsaishi.png', width: 24, height: 21,),
                  SizedBox(width: 5,),
                  Text("体育赛事", style: TextStyle(color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),),
                ],
              ),
              Row(
                children: [
                  Text("查看全部", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                  SizedBox(height: 5,),
                  Icon(Icons.chevron_right_outlined, size: 24, color: Color(0xFFB2B3BD),)
                ],
              )
            ],
          ),
          const SizedBox(height: 15,),
          controller.recommendSportList.isNotEmpty ? SizedBox(
            height: 380,
            width: double.infinity,
            child: Swiper(
              autoplayDisableOnInteraction: false,
              itemCount: 5, itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return Column(
                  children: [
                    Row(
                      children: [
                        _buildItem(controller.recommendSportList[0].image, controller.recommendSportList[0].name),
                        const SizedBox(width: 10,),
                        _buildItem(controller.recommendSportList[1].image, controller.recommendSportList[1].name),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        _buildItem(controller.recommendSportList[2].image, controller.recommendSportList[2].name),
                        const SizedBox(width: 10,),
                        _buildItem(controller.recommendSportList[3].image, controller.recommendSportList[3].name),
                      ],
                    )
                  ],
                );
              });
            }, pagination: const SwiperPagination(),),
          ) : Container()
        ],
      );
    });
  }

  Widget _buildItem(String imageStr, String nameTime) {
    return GestureDetector(
      child: Container(
        width: Get.width / 2 - 20,
        height: 146,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imageStr), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.only(left: 30),
        child:Stack(
          children: [
            Positioned.fill(
              bottom: 7,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  nameTime,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        controller.openSportGame();
      },
    );
  }
}
