import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/rebate/logic/logic.dart';
import 'package:kkguoji/pages/rebate/view/rebate_ratio_widget.dart';
import 'package:kkguoji/pages/rebate/view/rebate_records_widget.dart';

import '../../../utils/route_util.dart';
import 'auto_rebate_widget.dart';

class KKRebatePage extends StatelessWidget {
  KKRebatePage({super.key});
  final controller = Get.find<KKRebateLogic>();
  List widgets = [KKAutoRebateWidget(), KKRebateRecordsWidget(), KKRebateRatioWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 285,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Swiper(
                          autoplayDisableOnInteraction:false,
                          autoplay: true,
                          itemCount: 5, itemBuilder: (BuildContext context, int index) {
                          return Container(color: Colors.black,);
                        },
                          pagination: const SwiperPagination(), ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 15, right: 15,
                        child:  Container(
                          height: 70,
                          color: Colors.blue,
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
                                      Text("199.50 ¥", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                                    ],
                                  ),
                                ],
                              ),
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
                        ),
                      ),


                    ],
                  ),
                ),
                 const SizedBox(height: 15,),
                Obx((){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTextButton("自助返水", controller.rebateType.value == 0, 0),
                      _buildTextButton("返水记录", controller.rebateType.value == 1, 1),
                      _buildTextButton("返水比例", controller.rebateType.value == 2, 2),

                    ],
                  );
                }),
                const SizedBox(height: 15,),
                Obx(() => widgets[controller.rebateType.value])

              ],
            ),
          ),
          Positioned(
            top: 0,
              left: 0, right: 0,
              child:Container(
                height: 88,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0x00050820), Color(0xFF11163C)])
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: TextButton(onPressed: (){
                          RouteUtil.popView();
                        }, child: Image.asset("assets/images/back_normal.png", width: 20, height: 20,)),
                      ),
                      const SizedBox(
                        height: 44,
                        child:Center(child: Text("返水", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),))

                      ),
                      const SizedBox(width: 40,)
                    ],
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String text, bool isSelected, int index) {
    return Container(
      width: 78,
      height: 33,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected? const Color(0xFF171A26) : const Color(0xFF222633),
          border:isSelected? Border.all( color: const Color(0xFF3D35C6), width: 2):null
      ),
      child: Center(
        child: TextButton(
          onPressed: (){
            controller.changeRebateType(index);
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