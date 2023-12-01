import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class KKHomeRealWidget extends StatelessWidget {
  const KKHomeRealWidget({super.key});

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
                Text("KK真人", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),),
                Text("热门视讯台桌", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
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
          height: 510,
          width: double.infinity,
          child: Swiper(
            autoplayDisableOnInteraction:false,
            itemCount: 5, itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                _buildItem("assets/images/home_jingdianbaijiale.png", "经典百家乐", "120人在玩"),
                const SizedBox(height: 10,),
                _buildItem("assets/images/home_jingdianbaijiale.png", "经典百家乐", "120人在玩"),
                const SizedBox(height: 10,),
                _buildItem("assets/images/home_jingdianbaijiale.png", "经典百家乐", "120人在玩"),
              ],
            );
          },
            pagination: const SwiperPagination(), ),
        )


      ],
    );
  }


  Widget _buildItem(String imageStr, String nameTime,  String peropleCount) {
    return Container(
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
    );
  }

}
