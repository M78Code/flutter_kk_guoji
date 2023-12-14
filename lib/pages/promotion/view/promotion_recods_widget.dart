import 'package:flutter/material.dart';
import 'package:kkguoji/pages/promotion/view/promotion_mine.dart';
import 'package:kkguoji/pages/promotion/view/promotion_rebate_widget.dart';
import 'package:kkguoji/pages/promotion/view/promotion_user_inquiry_widget.dart';


class KKPromotionRecodsWidget extends StatelessWidget {
  const KKPromotionRecodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextButton("我的推广", true),
                _buildTextButton("业绩查询", false),
                _buildTextButton("玩家查询", false),
                _buildTextButton("返佣比例", false),

              ],
            ),
            const SizedBox(height: 20,),
            const MyPromotionWidget(),
          ],
        ),
      ),
    );
  }

 Widget _buildTextButton(String text, bool isSelected) {
    return Container(
      width: 76,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isSelected? const Color(0xFF171A26) : const Color(0xFF222633),
        border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: Center(
        child: TextButton(
          onPressed: (){

          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          child: Text(text, style: TextStyle(color: isSelected? Colors.white: const Color(0xFF707A8C), fontSize: 13)),
        ),
      ),
    );
  }
}
