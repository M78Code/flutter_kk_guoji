import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/logic.dart';

class KKRebateRatioWidget extends StatelessWidget {
   KKRebateRatioWidget({super.key});
  final controller = Get.find<KKRebateLogic>();
   final textList = ["全部", "电子", "视讯", "体育", "彩票"];
  final imageList = [
    "assets/images/rebate/rebate_all_selected.png",
    "assets/images/rebate/rebate_dianzi_normal.png",
    "assets/images/rebate/rebate_shixun_normal.png",
    "assets/images/rebate/rebate_tiyu_normal.png",
    "assets/images/rebate/rebate_caipiao_normal.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF222633)
          ),
          child: Obx((){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: textList.asMap().entries.map((e) {
                return _buildTextButton(textList[e.key], imageList[e.key], e.key == controller.ratioType.value, e.key);
              }).toList(),
            );
          }),
        ),
        const SizedBox(height: 15,),
        Container(
          color: const Color(0x1F6A6CB2),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 26,
          child:  const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("游戏类型", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),
              SizedBox(
                  width:70,
                  child: Center(
                    child: Text("返回比例", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),),
                  )
              ),
            ],
          ),
        ),
        MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return  Container(
              height: 37,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 70, child: Center(
                    child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),
                  SizedBox(width: 70, child: Center(
                    child: Text("100348", style: TextStyle(color: Colors.white, fontSize: 14),),
                  ),),
                ],
              ),
            );
          }, itemCount: 10,)),
      ],
    );
  }

  Widget _buildTextButton(String text,String imagePath, bool isSelected, int index) {
    return Expanded(child: Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isSelected? const LinearGradient(colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)]) : null,
        // border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: TextButton(
          onPressed: (){
            controller.ratioType.value = index;
          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 16, height: 16,),
              const SizedBox(width: 3,),
              Text(text, style: TextStyle(color: isSelected? Colors.white: const Color(0xFF707A8C), fontSize: 13)),
            ],
          )
      ),
    ));
  }


}