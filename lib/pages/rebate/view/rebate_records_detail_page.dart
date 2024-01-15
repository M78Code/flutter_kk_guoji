import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/rebate/logic/detail_logic.dart';
import 'package:kkguoji/widget/custome_app_bar.dart';

class KKRecordDetailPage extends StatelessWidget {
  KKRecordDetailPage({super.key});
  final controller = Get.find<DetailLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KKCustomAppBar(
        "返水详情"
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0x1F6A6CB2),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 26,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 120,
                      child: Text(
                        "游戏名称",
                        style: TextStyle(
                            color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    ),
                SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        "打码总量",
                        style: TextStyle(
                            color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    )),
                SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        "返水比例",
                        style: TextStyle(
                            color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    )),
                SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        "金额",
                        style: TextStyle(
                            color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    )),
              ],
            ),
          ),
          Obx((){
            return MediaQuery.removePadding(
                 context: context,
                 removeTop: true,
                 child: ListView.builder(
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     Map receiveM =
                     controller.detailList.value[index];
                     return Container(
                       height: 50,
                       padding:
                       const EdgeInsets.symmetric(horizontal: 10),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(
                             width: 120,
                               child: Text(
                                 receiveM["game_name"]
                                     .toString(),
                                 // textAlign: TextAlign.center,
                                 style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 13,
                                     fontWeight: FontWeight.w500),
                               ),
                           ),
                           SizedBox(
                             width: 70,
                             child: Center(
                               child: Text(
                                 receiveM["bet"].toString(),
                                 style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w600),
                               ),
                             ),
                           ),
                           SizedBox(
                             width: 70,
                             child: Center(
                               child: Text(
                                 "${receiveM["rate"]* 100.0}%",
                                 style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w600),
                               ),
                             ),
                           ),
                           SizedBox(
                             width: 50,
                             child: Center(
                               child: Text(
                                 "+${receiveM["money"]}",
                                 style: const TextStyle(
                                     color: Color(0xFF20F752),
                                     fontSize: 12,
                                     fontWeight: FontWeight.w600),
                               ),
                             ),
                           ),
                         ],
                       ),
                     );
                   },
                   itemCount: controller.detailList.value.length,
                 ));
          })
        ],
      ),
    );
  }
}
