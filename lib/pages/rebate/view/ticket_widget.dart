import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/logic.dart';
typedef ClickTicketType = void Function(String typeStr);
class KKTicketWidget extends StatelessWidget {
  ClickTicketType? clickTicketType;
   KKTicketWidget({this.clickTicketType, super.key});
  final controller = Get.find<KKRebateLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: 180,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF222633),
        // color: Colors.red
      ),
      child: Column(
        children: [
           SizedBox(
            height: 40,
            width: double.infinity,
            child:
            GestureDetector(
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFF1A1E2A),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              hintText: "搜索游戏",
                              hintStyle:
                              TextStyle(color: Color(0xFF687083), fontSize: 12),
                              border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                          color: Color(0xFF687083),
                        )),
                  ],
                ),
              ),
              onTap: (){

              },
            )
          ),
          const SizedBox(height: 10,),
          Expanded(child: MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if(clickTicketType != null) {
                      clickTicketType!(controller.allTicketKeyList.value[index]);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 33,
                        width: double.infinity,
                        child: Text(controller.allTicketKeyList.value[index], style: TextStyle(color:controller.allTicketKeyList.value[index]==controller.tickTypeStr.value?const Color(0xFF5D5FEF): const Color(0xFF687083), fontSize: 13, decoration: TextDecoration.none),),
                      ),
                    ],
                  ),
                );
              },
              itemCount: controller.allTicketKeyList.length,
              shrinkWrap: true,
            ),)),


        ],
      ),
    );
  }
}
