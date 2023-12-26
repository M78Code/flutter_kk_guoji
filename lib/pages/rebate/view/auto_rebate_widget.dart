import 'package:flutter/material.dart';
import 'package:kkguoji/pages/rebate/model/auto_record_model.dart';

import '../logic/logic.dart';
import 'package:get/get.dart';

class KKAutoRebateWidget extends StatelessWidget {
  KKAutoRebateWidget({super.key});

  final controller = Get.find<KKRebateLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.autoRecordList.value.isNotEmpty? Column(
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
                    width: 70,
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
                        "总大码量",
                        style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    )),
                SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        "返水比例",
                        style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
                      ),
                    )),
                SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        "金额",
                        style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
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
                    height: 37,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "100348",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "100348",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "100346",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              "100346",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 10,
              )),
          Obx(() {
            return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    KKAutoRecordModel model = controller.autoRecordList.value[index];
                    return Container(
                      height: 37,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                model.gameTypeName ?? "",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                model.totalBet ?? "",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                "${model.rate ?? 0}%",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(
                                model.totalMoney ?? "",
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.autoRecordList.value.length,
                ));
          })
        ],
      ): Center(
        child: Image.asset(
          "assets/images/rebate/nodata.png",
          width: 200,
          height: 223,
        ),
      );
    });
  }
}
