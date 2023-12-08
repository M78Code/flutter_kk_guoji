
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';

class KKHomeSportsWidget extends StatelessWidget {
  KKHomeSportsWidget({super.key});
  final controller = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("KK体育", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),),
                Text("热门赛事推荐", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
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
        SizedBox(
          height: 420,
          width: double.infinity,
          child: Swiper(
            autoplayDisableOnInteraction:false,
            itemCount: 5, itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem("assets/images/home_football.png", "足球", "120人在玩"),
                const SizedBox(height: 10,),
                _buildItem("assets/images/home_football.png", "篮球", "120人在玩"),
                const SizedBox(height: 10,),
                _buildItem("assets/images/home_football.png", "网球", "120人在玩"),
              ],
            );
          },
            pagination: const SwiperPagination(), ),
        )


      ],
    );
  }

  Widget _buildItem(String imageStr, String nameTime,  String peropleCount) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 123,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageStr), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nameTime, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),),
            Text(peropleCount, style: const TextStyle(color: Colors.white, fontSize: 12),),

          ],
        ),
      ),
      onTap: (){
        controller.openSportGame();
      },
    );
  }
}
