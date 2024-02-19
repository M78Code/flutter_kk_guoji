import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/rebate/model/record_rate_model.dart';
import 'package:kkguoji/pages/rebate/view/ticket_widget.dart';
import '../logic/logic.dart';

class KKRebateRatioWidget extends StatelessWidget {
  KKRebateRatioWidget({super.key});

  final controller = Get.find<KKRebateLogic>();
  final GlobalKey selectedKey = GlobalKey();
  late OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 41,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFF222633)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 7,child: Obx(() {
                    return Row(
                      key: selectedKey,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.gameList.value.asMap().entries.map((e) {
                        return _buildTextButton(context, e.value, e.key);
                      }).toList(),
                    );
                  }),),
                  Expanded(flex: 6,child: Obx(() {
                    return _buildTicketButton(
                        context, controller.ticketMap, controller.gameList.length);
                  }),),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
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
                          "返水比例",
                          style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12),
                        ),
                      )),
                ],
              ),
            ),
            Obx(() {
              return controller.gameIndex.value != 3
                  ? MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: controller.recordRateList.isNotEmpty?ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      KKRecordRateModel model =
                      controller.recordRateList[index];
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
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: Center(
                                child: Text(
                                  "${(model.rate ?? 0) * 100} %",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.recordRateList.value.length,
                  ):Center(
                    child: Image.asset("assets/images/rebate/nodata.png", width: 200, height: 223,),
                  ))
                  : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map map = controller.allTicketMap[controller.tickTypeStr]
                      [index];
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
                                  map["playName"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 70,
                              child: Center(
                                child: Text(
                                  "${map["returnPointRatio"]}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: (controller.allTicketMap[controller.tickTypeStr]
                    as List)
                        .length,
                  ));
            })
          ],
        ),
        Positioned(
          top: 50, right: 0,
          height: 320,
          child: Obx((){
            return Offstage(
              offstage: controller.isSelectedGames.value,
              child:  KKTicketWidget(
                clickTicketType: (typeStr) {
                  controller.isSelectedGames.value = !controller.isSelectedGames.value;
                  controller.clickTicketType(typeStr);
                },
              ),
            );

          }),
        )
      ],
    );
  }

  Widget _buildTextButton(BuildContext context, Map gameInfo, int index) {
    bool isSelected = controller.gameIndex.value == index;
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isSelected
            ? const LinearGradient(
            colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)])
            : null,
        // border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: TextButton(
          onPressed: () {
            controller.gameIndex.value = index;
            controller.isSelectedGames.value = true;
            controller.getRatio(gameInfo["id"]);

          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   imagePath,
              //   width: 16,
              //   height: 16,
              // ),
              Image.network(
                isSelected ? gameInfo["icon_click"] : gameInfo["icon"],
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(gameInfo["name"],
                  style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF707A8C),
                      fontSize: 13)),
            ],
          )),
    );
  }

  Widget _buildTicketButton(BuildContext context, Map gameInfo, int index) {
    bool isSelected = controller.gameIndex.value == index;
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isSelected
            ? const LinearGradient(
            colors: [Color(0x5C3D35C6), Color(0x5C6C4FE0)])
            : null,
        // border:isSelected? Border.all( color: const Color(0xFF3D35C6)):null
      ),
      child: TextButton(
          onPressed: () {
            controller.gameIndex.value = index;
              controller.isSelectedGames.value = !controller.isSelectedGames.value;
              controller.getRatio(gameInfo["id"]);
          },
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                isSelected ? gameInfo["icon_click"] : gameInfo["icon"],
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(gameInfo["name"],
                  style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF707A8C),
                      fontSize: 13)),
              const SizedBox(
                width: 3,
              ),
              controller.isSelectedGames.value? Image.asset(Assets.rebateTicketSelected, width: 15, height: 15,):Image.asset(Assets.rebateTicketNormal, width: 15, height: 15,)

            ],
          )),
    );
  }
  //
  // void _showTimeWidget(BuildContext context) {
  //   Widget child = KKTicketWidget(
  //     clickTicketType: (typeStr) {
  //       overlayEntry.remove();
  //       controller.isSelectedGames.value = !controller.isSelectedGames.value;
  //       controller.clickTicketType(typeStr);
  //     },
  //   );
  //   RenderBox renderBox =
  //       selectedKey.currentContext!.findRenderObject() as RenderBox;
  //   final buttonSize = renderBox.size;
  //   final buttonPosition = renderBox.localToGlobal(Offset.zero);
  //   showOverlay(context, child, buttonPosition.dy + buttonSize.height+10);
  // }
  //
  // void showOverlay(BuildContext context, Widget child, double top) {
  //   overlayEntry = OverlayEntry(
  //     maintainState: true,
  //     builder: (context) => Stack(
  //       children: [
  //         Positioned.fill(
  //           child: GestureDetector(
  //             onTap: () {
  //               overlayEntry.remove();
  //             },
  //             child: Container(
  //               color: Colors.transparent,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           right: 0,
  //           top: top,
  //           child: child,
  //         ),
  //       ],
  //     ),
  //   );
  //   Overlay.of(context)?.insert(overlayEntry);
  // }
}
