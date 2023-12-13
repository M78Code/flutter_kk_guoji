
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';

class MyPromotionWidget extends StatelessWidget {
  const MyPromotionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
              color: const Color(0xFF222633),
              borderRadius: BorderRadius.circular(6)
          ),
          child: Column(
            children: [
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/promotion/promotion_my_reward.png", width: 40, height: 41,),
                        const SizedBox(width: 20,),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("我获得的总奖励", style: TextStyle(color: Colors.white, fontSize: 12),),
                            SizedBox(height: 8,),
                            Text("199.50 ¥", style: TextStyle(color: Color(0xFFFF8A00), fontSize: 20),),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 100, height: 39,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextButton(
                        child: const Text("全部领取", style: TextStyle(color: Colors.white, fontSize: 12),),
                        onPressed: (){

                        },
                      ),
                    )
                  ],
                ),
              ), ),
              Container(
                height: 1.0,
                color: const Color.fromRGBO(255, 255, 255, 0.06),
              ),
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/promotion/promotion_my_reward.png", width: 40, height: 41,),
                        const SizedBox(width: 20,),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("历史总金额", style: TextStyle(color: Colors.white, fontSize: 12),),
                            SizedBox(height: 8,),
                            Text("199.50 ¥", style: TextStyle(color: Colors.white, fontSize: 20),),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 100, height: 39,
                      decoration: BoxDecoration(
                        // gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xFF2E374E)
                      ),
                      child: TextButton(
                        child: const Text("全部领取", style: TextStyle(color: Colors.white, fontSize: 12),),
                        onPressed: (){
                            RouteUtil.pushToView(Routes.promation_history);
                        },
                      ),
                    )
                  ],
                ),
              ), ),
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 19.w,),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.w,
              childAspectRatio: 110 / 63
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0x1F6A6CB2),
                borderRadius: BorderRadius.circular(4)
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("推荐码", style: TextStyle(color: Colors.white, fontSize: 12),),
                  SizedBox(height: 8,),
                  Text("7455749", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ); // Passing index + 1 as item number
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("佣金每日结算, 分享好友获得更多奖励呦!", style: TextStyle(color: Color(0xFFFF8A00), fontSize: 13),),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF222633),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/promotion/promotion_reward_bg.png", ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100, height: 39,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2E374E)
                        ),
                        child: TextButton(
                          child: const Text("全部领取", style: TextStyle(color: Colors.white, fontSize: 12),),
                          onPressed: (){

                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        const Text("分享下载链接1", style: TextStyle(color: Colors.white, fontSize: 14),),
                        const SizedBox(height: 10,),
                        Container(
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF181C27),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("745759", style: TextStyle(color: Colors.white, fontSize: 15),),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF32394F),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 40, height: 40,
                                  child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Image.asset("assets/images/promotion/copy.png", width: 20, height: 20,),
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 20,),
                        const Text("分享下载链接2", style: TextStyle(color: Colors.white, fontSize: 14),),
                        const SizedBox(height: 10,),
                        Container(
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF181C27),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("745759", style: TextStyle(color: Colors.white, fontSize: 15),),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF32394F),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 40, height: 40,
                                  child: TextButton(
                                    onPressed: (){

                                    },
                                    child: Image.asset("assets/images/promotion/copy.png", width: 20, height: 20,),
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 15,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),


          ],
        ),
        const SizedBox(height: 50,)
      ],
    );
  }
}
