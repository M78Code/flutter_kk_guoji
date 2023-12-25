import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/logic.dart';

class KKRebateRecordsWidget extends StatelessWidget {
  KKRebateRecordsWidget({super.key});

  final textList = ["今天", "昨天", "本月", "上月"];
  final controller = Get.find<KKRebateLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(child: ),
            Container(
              height: 41,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF222633)),
              child: Obx(() => Row(
                      children: textList.asMap().entries.map((e) {
                    return _buildDateWidget(textList[e.key],
                        e.key == controller.dateType.value, e.key);
                  }).toList())),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF222633),
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
                          hintText: "搜索玩家ID",
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
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Obx(() {
          return controller.dateTotalCount.value > 0
              ? Column(
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
                              width: 52.5,
                              child: Center(
                                child: Text(
                                  "时间",
                                  style: TextStyle(
                                      color: Color(0xFFB2B3BD), fontSize: 12),
                                ),
                              )),
                          SizedBox(
                              width: 70,
                              child: Center(
                                child: Text(
                                  "游戏类型",
                                  style: TextStyle(
                                      color: Color(0xFFB2B3BD), fontSize: 12),
                                ),
                              )),
                          SizedBox(
                              width: 70,
                              child: Center(
                                child: Text(
                                  "返水金额",
                                  style: TextStyle(
                                      color: Color(0xFFB2B3BD), fontSize: 12),
                                ),
                              )),
                          SizedBox(
                              width: 70,
                              child: Center(
                                child: Text(
                                  "反水余额",
                                  style: TextStyle(
                                      color: Color(0xFFB2B3BD), fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ),
                    MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 55,
                                    child: Center(
                                      child: Text(
                                        "2023-11-11 11:59:32",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        "100348",
                                        style: TextStyle(
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
                                        "100346",
                                        style: TextStyle(
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
                                        "100346",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: 10,
                        ))
                  ],
                )
              : Center(
                  child: Image.asset(
                    "assets/images/rebate/nodata.png",
                    width: 200,
                    height: 223,
                  ),
                );
        })
      ],
    );
  }

  Widget _buildDateWidget(String text, bool isSelected, int index) {
    return Container(
      width: 48,
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)])
            : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          controller.dateType.value = index;
        },
        style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF707A8C),
              fontSize: 12),
        ),
      ),
    );
  }
}
