import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/rebate/model/record_rate_model.dart';
<<<<<<< HEAD

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
=======
import '../logic/logic.dart';

class KKRebateRatioWidget extends StatelessWidget {
  KKRebateRatioWidget({super.key});

  final controller = Get.find<KKRebateLogic>();
  final textList = ["全部", "电子", "视讯", "体育", "彩票"];
  final imageList = ["assets/images/rebate/rebate_all_selected.png", "assets/images/rebate/rebate_dianzi_normal.png", "assets/images/rebate/rebate_shixun_normal.png", "assets/images/rebate/rebate_tiyu_normal.png", "assets/images/rebate/rebate_caipiao_normal.png"];
>>>>>>> leon

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
<<<<<<< HEAD
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF222633)
          ),
          child: Obx((){
=======
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xFF222633)),
          child: Obx(() {
>>>>>>> leon
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: textList.asMap().entries.map((e) {
                return _buildTextButton(textList[e.key], imageList[e.key], e.key == controller.ratioType.value, e.key);
              }).toList(),
            );
          }),
        ),
<<<<<<< HEAD
        const SizedBox(height: 15,),
=======
        const SizedBox(
          height: 15,
        ),
>>>>>>> leon
        Container(
          color: const Color(0x1F6A6CB2),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 26,
<<<<<<< HEAD
          child:  const Row(
=======
          child: const Row(
>>>>>>> leon
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
<<<<<<< HEAD
                  width:120,
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
=======
                  width: 120,
                  child: Center(
                    child: Text(
                      "游戏类型",
                      style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
                    ),
                  )),
              SizedBox(
                  width: 70,
                  child: Center(
                    child: Text(
                      "返回比例",
                      style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
                    ),
                  )),
>>>>>>> leon
            ],
          ),
        ),
        Obx(() {
<<<<<<< HEAD
          return MediaQuery.removePadding(context: context, removeTop: true, child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              KKRecordRateModel model = controller.recordRateList.value[index];
              return  Container(
                height: 37,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 120, child: Center(
                      child: Text(model.name ?? "", style: const TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center,),
                    ),),
                    SizedBox(width: 70, child: Center(
                      child: Text("${model.rate ?? 0} %", style: const TextStyle(color: Colors.white, fontSize: 14),),
                    ),),
                  ],
                ),
              );
            }, itemCount: controller.recordRateList.value.length,));
=======
          return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  KKRecordRateModel model = controller.recordRateList.value[index];
                  return Container(
                    height: 37,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Center(
                            child: Text(
                              model.name ?? "",
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "${model.rate ?? 0} %",
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: controller.recordRateList.value.length,
              ));
>>>>>>> leon
        }),
      ],
    );
  }

<<<<<<< HEAD
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
=======
  Widget _buildTextButton(String text, String imagePath, bool isSelected, int index) {
    return Expanded(
        child: Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isSelected ? const LinearGradient(colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)]) : null,
        // border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: TextButton(
          onPressed: () {
>>>>>>> leon
            controller.ratioType.value = index;
          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
<<<<<<< HEAD
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


=======
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(text, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF707A8C), fontSize: 13)),
            ],
          )),
    ));
  }
>>>>>>> leon
}
