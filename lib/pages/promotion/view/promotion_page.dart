import 'package:flutter/material.dart';
import 'package:kkguoji/pages/promotion/view/promotion_reward_widget.dart';
class KKPromotionPage extends StatelessWidget {
  const KKPromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Scaffold(
      appBar: AppBar(
        title:  const SizedBox(
          width: 220,
          height: 44,
          child: TabBar(
            labelColor: Colors.white,
            indicatorWeight:3.0,
            indicatorColor: Color(0xFF6C4FE0),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
            unselectedLabelColor: Color(0xFFB2B3BD),
            labelStyle: TextStyle(color: Colors.white, fontSize: 18),
            unselectedLabelStyle: TextStyle(color: Color(0xFFB2B3BD), fontSize: 18),
            tabs: [
              Text("推广奖励"),
              Text("推广记录")
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: TabBarView(children: [
        const KKPromotionRewardWidget(),
        Container(
          child: Text("2", style: TextStyle(color: Colors.white),),
        ),
      ],

      ),
    ));
  }
}
