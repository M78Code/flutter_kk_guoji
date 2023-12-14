
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/promotion/logic/promotion_logic.dart';

class KKPromotionRewardWidget extends StatelessWidget {
  KKPromotionRewardWidget({super.key});
  final controller = Get.find<PromotionLogic>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 6,),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        const Text("推荐码", style: TextStyle(color: Colors.white, fontSize: 14),),
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
                                Obx(() {
                                  return Text(controller.promotionModel.value?.inviteCode ?? "", style: TextStyle(color: Colors.white, fontSize: 15),);
                                }),
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
                        const Text("推荐链接", style: TextStyle(color: Colors.white, fontSize: 14),),
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
                                Obx(() {
                                  return Text(controller.promotionModel.value?.domain?.first.url ?? "",
                                    style: const TextStyle(color: Colors.white, fontSize: 15),);

                                }),
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
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("我获得的总奖励", style: TextStyle(color: Colors.white, fontSize: 12),),
                                const SizedBox(height: 8,),
                                Obx(() {
                                  return Text("${controller.promotionModel.value?.totalCommission ?? 0.0}¥",
                                    style: const TextStyle(color: Color(0xFFFF8A00), fontSize: 20),);

                                })
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
                      children: [
                        Image.asset("assets/images/promotion/promotion_my_reward.png", width: 40, height: 41,),
                        const SizedBox(width: 20,),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("我邀请好友总数", style: TextStyle(color: Colors.white, fontSize: 12),),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Text("${controller.promotionModel.value?.teamTotalCount ?? 0}人",
                                style: const TextStyle(color: Colors.white, fontSize: 20),);

                            })
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  const Text("推荐奖励", style: TextStyle(color: Colors.white, fontSize: 16),),
                  const SizedBox(height: 15,),
                  Container(
                    color: const Color(0x1F6A6CB2),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 26,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("推荐人数", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                        Text("每人需充值 ¥", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                        Text("奖励 ¥", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 52.5, child: Center(
                              child: Text(index.toString(), style: const TextStyle(color: Colors.white, fontSize: 14),),
                            ),),
                            const SizedBox(width: 82.5, child: Center(
                              child: Text("100.00", style: TextStyle(color: Colors.white, fontSize: 14),),
                            ),),
                            const Text("1000.00", style: TextStyle(color: Color(0xFFFF8A00), fontSize: 12),),
                          ],
                        ),
                      );
                    }, itemCount: 10,)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
