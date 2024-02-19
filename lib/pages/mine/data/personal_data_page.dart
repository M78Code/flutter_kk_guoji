import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/data/personal_data_logic.dart';
import 'package:kkguoji/pages/mine/data/progressbar.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';

class KKPersonalDataPage extends StatelessWidget {
  KKPersonalDataPage({super.key});
  final controller = Get.find<PersonalDataLogic>();
  final textList = ["今天", "昨天", "本月", "上月"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KKCustomAppBar("个人数据"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Container(
                    height: 63,
                    decoration: BoxDecoration(
                      color: const Color(0x1F6A6CB2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("我的盈利", style: TextStyle(color: Colors.white, fontSize: 12),),
                        Obx((){
                          return Text("${controller.data.value["total_profit"]}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900 ),);

                        }),
                      ],
                    ),
                  )),
                  const SizedBox(width: 15,),
                  Expanded(child: Container(
                    height: 63,
                    decoration: BoxDecoration(
                      color: const Color(0x1F6A6CB2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("我的彩金", style: TextStyle(color: Colors.white, fontSize: 12),),
                        Obx((){
                          return Text("${controller.data.value["total_bonus"]}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900 ),);

                        }),
                      ],
                    ),
                  )),

                ],
              ),
              const SizedBox(height: 15,),
              Container(
                height: 41,
                width: 205,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFF222633)
                ),
                child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: textList.asMap().entries.map((e) {
                      return _buildDateWidget(textList[e.key], e.key == controller.dateType.value, e.key);
                    }).toList()
                )),
              ),
              const SizedBox(height: 15,),
              Obx((){
                return controller.gameList.isEmpty?Center(
                  child: Image.asset("assets/images/rebate/nodata.png", width: 200, height: 223,),
                ):
                Column(
                  children: [
                    Container(
                      color: const Color(0x1F6A6CB2),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 26,
                      child:  const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width:65,
                              child: Center(
                                child: Text("游戏类型", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                              )
                          ),
                          SizedBox(
                              width:65,
                              child: Center(
                                child: Text("局数", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                              )
                          ),
                          SizedBox(
                              width:54,
                              child: Center(
                                child: Text("盈利金额", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                              )
                          ),
                          // SizedBox(
                          //     width:65,
                          //     child: Center(
                          //       child: Text("yi", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                          //     )
                          // ),


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map data = controller.gameList[index];
                        return  Container(
                          height: 37,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 65, child: Center(
                                  child: Text(data["game_type_name"], style: const TextStyle(color: Colors.white, fontSize: 14),),
                                ),),
                                SizedBox(width: 65, child: Center(
                                  child: Text(data["count"].toString(), style:const TextStyle(color: Colors.white, fontSize: 14),),
                                ),),
                                SizedBox(width: 65, child: Center(
                                  child: Text(data["total_bet"], style: const TextStyle(color: Colors.white, fontSize: 14),),
                                ),),
                                Expanded(child: KKProgressbar(value: double.parse(data["total_bet"]).abs()/100000.0, width: 111, height: 7, outerDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.5),
                                    color: const Color(0xFF1B1F39)
                                ), innerDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.5),
                                    gradient: const LinearGradient(colors: [Color(0xFF0B3EC3), Color(0xFF3CB9FF)])
                                ),))
                              ]
                            // SizedBox(width: 70, child: Center(
                            //   child: Text(model.totalMoney??"", style: TextStyle(color: Colors.white, fontSize: 14),),
                            // ),),                    ],

                          ),
                        );
                      }, itemCount: controller.gameList.length,))
                    // Obx((){
                    //   return MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       Map data = controller.gameList[index];
                    //       return  Container(
                    //         height: 37,
                    //         padding: const EdgeInsets.symmetric(horizontal: 10),
                    //         child:  Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               SizedBox(width: 65, child: Center(
                    //                 child: Text(data["game_type_name"], style: const TextStyle(color: Colors.white, fontSize: 14),),
                    //               ),),
                    //               SizedBox(width: 65, child: Center(
                    //                 child: Text(data["count"].toString(), style:const TextStyle(color: Colors.white, fontSize: 14),),
                    //               ),),
                    //               SizedBox(width: 65, child: Center(
                    //                 child: Text(data["total_bet"], style: const TextStyle(color: Colors.white, fontSize: 14),),
                    //               ),),
                    //               Expanded(child: KKProgressbar(value: double.parse(data["total_bet"])/1000.0, width: 111, height: 7, outerDecoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(3.5),
                    //                   color: const Color(0xFF1B1F39)
                    //               ), innerDecoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(3.5),
                    //                   gradient: const LinearGradient(colors: [Color(0xFF0B3EC3), Color(0xFF3CB9FF)])
                    //               ),))
                    //             ]
                    //           // SizedBox(width: 70, child: Center(
                    //           //   child: Text(model.totalMoney??"", style: TextStyle(color: Colors.white, fontSize: 14),),
                    //           // ),),                    ],
                    //
                    //         ),
                    //       );
                    //     }, itemCount: controller.gameList.length,));
                    //
                    // })
                  ],
                );
              })

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateWidget(String text, bool isSelected, int index) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        gradient: isSelected? const LinearGradient(colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)]):null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: (){
          controller.changeDateType(index);
        },
        style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero)
        ),
        child: Text(text, style: TextStyle(color: isSelected? Colors.white:const Color(0xFF707A8C), fontSize: 12),),
      ),
    );
  }
}
