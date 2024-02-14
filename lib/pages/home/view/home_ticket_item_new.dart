import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/home/logic/logic.dart';
import 'package:kkguoji/utils/route_util.dart';

import '../../../common/models/jcp_bet_model.dart';
import '../../../model/home/jcp_game_model.dart';
import '../../../routes/routes.dart';
import '../../../services/user_service.dart';
import '../../../utils/function.dart';
import '../../../utils/json_util.dart';
import '../../../widget/show_toast.dart';
import '../logic/item_logic.dart';

class HomeTicketItemNew extends GetView<ItemLogic>{
  const HomeTicketItemNew(this.bgImageStr, this.logoImageStr, this.ballColors,
      this.groupIndex, this.itemIndex, this.openGame,
      {super.key});

  final ParamSingleCallback<String> openGame;
  final int itemIndex;
  final int groupIndex;
  final String bgImageStr;
  final String logoImageStr;
  final List<Color> ballColors;


  @override
  Widget build(BuildContext context) {
    // 获取对应的控制器
    // final controller = Get.find<ItemLogic>();
    // controller.tickInfo.value = controller.margeGameListNew[groupIndex][itemIndex];
    // controller.processData();
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Container(
        color: const Color(0xFF0F1921),
        child: Column(
          children: [
            Container(
              height: 64,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                image: DecorationImage(
                    image: AssetImage(bgImageStr),
                    fit: BoxFit.cover),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    logoImageStr,
                    width: 44,
                    height: 44,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          controller.tickInfo.value.lotteryName.toString(),
                          style: const TextStyle(color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        );
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "第",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.0),
                                ),
                                TextSpan(
                                  text: controller.tickInfo.value.last!
                                      .periodsNumber.toString(),
                                  style: const TextStyle(
                                      color: Color(0xFFF4B81C), fontSize: 11),
                                ),
                                const TextSpan(
                                  text: "期",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.0),
                                ),
                              ],
                            ))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                          visible: controller.getTicketState(),
                          child: Container(
                              color: const Color(0xFFFF563F),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 2),
                                child: Text(
                                  controller.getTicketStateString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              )),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                       Row(
                          children: [
                            Image.asset(
                              "assets/images/home_ticket_hit_icon.png",
                              width: 10.5,
                              height: 12,
                            ),
                            _buildTimeItem(0),
                            const SizedBox(
                              width: 2,
                            ),
                            _buildTimeItem(1),
                            const Text(
                              ":",
                              style: TextStyle(
                                  color: Color(0xFF2F03AB), fontSize: 18),
                            ),
                            _buildTimeItem(2),
                            const SizedBox(
                              width: 2,
                            ),
                            _buildTimeItem(3),
                            const Text(
                              ":",
                              style: TextStyle(
                                  color: Color(0xFF2F03AB), fontSize: 18),
                            ),
                            _buildTimeItem(4),
                            const SizedBox(
                              width: 2,
                            ),
                            _buildTimeItem(5),
                          ],
                        )
                    ],
                  ),
                  GestureDetector(
                        onTap: () {
                          openGame(controller.tickInfo.value.lotteryCode ?? '');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color.fromRGBO(
                                    255, 255, 255, 0.36),
                              )),
                          width: 48,
                          height: 46,
                          child: const Center(
                            child: Text(
                              "进入\n游戏",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 12),
                            ),
                          ),
                        ))
                ],
              ),
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.04, -1.00),
                  end: Alignment(-0.04, 1),
                  colors: [Color(0xFF2E374E), Color(0xFF232B43)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(67),
                    bottomRight: Radius.circular(67),
                  ),
                ),
              ),
              child: Obx(() {
                return _buildDrawingBall(
                    controller.tickInfo.value.last?.drawingResult ?? '');
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: controller.tickInfo.value.play!.cachePlayList!
                      .isNotEmpty
                      ? List.generate(
                      controller.tickInfo.value.play!.cachePlayList!.length, (index) {
                    return _buildOddsItem(controller.tickInfo.value.play!
                        .cachePlayList![index]);
                  })
                      : List.generate(
                      controller.tickInfo.value.play!.lotteryPlayTypeList!
                          .length, (index) {
                    return _buildOddsItemNN(controller.tickInfo.value.play!
                        .lotteryPlayTypeList![index]);
                  }));
            }),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const ShapeDecoration(
                color: Color(0xFF1A1F2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 101,
                        height: 31,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.5),
                          color: const Color(0xFF4338C9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  controller.decrementNumber();
                                },
                                child: Image.asset(
                                  "assets/images/home_sub_icon.png",
                                  width: 12,
                                  height: 2.5,
                                ),
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF30298B),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: const Color(0xFF9FC1EA))),
                              child: TextField(
                                  controller: controller.numberController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    border: InputBorder
                                        .none, // 设置为 none 去掉下划线
                                  ),
                                ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 31,
                              child: TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero),
                                    alignment: Alignment.center),
                                onPressed: () {
                                  controller.incrementNumber();
                                },
                                child: Image.asset(
                                  "assets/images/home_add_icon.png",
                                  width: 12.5,
                                  height: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                          width: 90,
                          height: 31,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.5),
                              gradient: controller.tickInfo.value.current!
                                  .status == 0 ? const LinearGradient(
                                  colors: [
                                    Color(0xFF3D35C6),
                                    Color(0xFF6C4FE0)
                                  ]) : const LinearGradient(colors: [
                                Color(0xFF686F83),
                                Color(0xFF686F83)
                              ])),
                          child: TextButton(
                            onPressed: () {
                              if (controller.tickInfo.value.current!.status ==
                                  0) {
                                if (UserService.to.isLogin == false) {
                                  RouteUtil.pushToView(Routes.loginPage);
                                  return;
                                }
                                if (controller.betList.isNotEmpty) {
                                  if (controller.numberController.text
                                      .isNotEmpty) {
                                    controller.betGame();
                                  }
                                } else {
                                  ShowToast.showToast('请选择下注类型');
                                }
                              }
                            },
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.zero)),
                            child: const Text(
                              "快捷投注",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeItem(int index) {
    return Container(
        width: 15,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
            )),
        child: Center(
          child: Text(
            controller.timeList[index],
            style: const TextStyle(color: Color(0xFF2F03AB), fontSize: 18),
          ),
        ));
  }

  Widget _buildDrawingBall(String number) {
    var split = number.split(',');
    print("开奖号码： ${JsonUtil.encodeObj(split)}");
    bool isLhc = controller.tickInfo.value.lotteryCode == "XGLHC";
    if (isLhc) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(split.length, (index) {
            return _buildLhcBall(split[index]);
          }));
    } else {
      List<String> modifiedList = [];
      for (int i = 0; i < split.length; i++) {
        modifiedList.add(split[i]);
        if (i < split.length - 1) {
          modifiedList.add('+');
        }
        if (i == split.length - 1) {
          modifiedList.add('=');
          modifiedList.add(controller.calculateSum(split).toString());
        }
      }
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(modifiedList.length, (index) {
            if (index % 2 == 0) {
              return _buildItemBall(modifiedList[index], ballColors);
            } else {
              return _buildSymbolView(modifiedList[index]);
            }
          }));
    }
  }

  Widget _buildOddsItem(CachePlayList playInfo) {
    String odds = playInfo.odds.toString();
    odds = odds.contains('.') ? (odds.endsWith('0') ? odds.replaceAll(
        RegExp(r'\.0*$'), '') : odds) : odds;
    String maxOdds = playInfo.maxOdds.toString();
    maxOdds =
    maxOdds.contains('.') ? (maxOdds.endsWith('0') ? maxOdds.replaceAll(
        RegExp(r'\.0*$'), '') : maxOdds) : maxOdds;
    bool isPCNN = controller.tickInfo.value.lotteryCode == "PCNN";
    bool isSelect = playInfo.isSelect ?? false;
    String content = "";
    // print('xiaoan 赔率选项：$isPCNN${controller.tickInfo.lotteryCode}');
    if (isPCNN) {
      content =
      "${playInfo.playName}:${playInfo.odds.toString()}-${playInfo.maxOdds
          .toString()}";
      print('xiaoan 赔率选项：$content');
    } else {
      if (controller.tickInfo.value.lotteryCode == 'JNDEB' ||
          controller.tickInfo.value.lotteryCode == 'JNDSI' ||
          controller.tickInfo.value.lotteryCode == 'JNDWU') {
        content = "${playInfo.playName}: $maxOdds";
      } else {
        content = "${playInfo.playName}: $odds";
      }
    }
    return GestureDetector(
      onTap: () {
        if (!isSelect) {
          playInfo.isSelect = true;
          controller.betList.add(JcpBetModel(
              lotteryCode: controller.tickInfo.value.lotteryCode ?? '',
              playTypeCode: playInfo.playTypeCode ?? '',
              sonPlayTypeCode: playInfo.sonPlayTypeCode ?? '',
              playCode: playInfo.playCode ?? '',
              betContent: playInfo.playCode ?? '',
              betAmount: controller.numberController.text));
        } else {
          playInfo.isSelect = false;
          controller.betList.removeWhere((element) =>
          element.playCode == playInfo.playCode);
        }
        print('以选中选项：${JsonUtil.encodeObj(controller.betList)}');
      },
      child: Container(
        width: 67,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF2E374E),
            border: Border.all(width: 2,
                color: playInfo.isSelect ?? false ? Color(0xFF755EFF) : Color(
                    0xFF2E374E))),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildOddsItemNN(Play playInfo) {
    bool isSelect = playInfo.cachePlayList?[0].isSelect ?? false;
    bool isPCNN = controller.tickInfo.value.lotteryCode == "PCNN";
    String content = "";
    if (isPCNN) {
      content =
      "${playInfo.cachePlayList?[0].playName}:${playInfo.cachePlayList?[0].odds
          ?.toInt()}-${playInfo.cachePlayList?[0].maxOdds?.toInt()}";
    } else {
      content =
      "${playInfo.cachePlayList?[0].playName}: ${playInfo.cachePlayList?[0].odds
          .toString()}";
    }
    return GestureDetector(
      onTap: () {
        if (!isSelect) {
          playInfo.cachePlayList?[0].isSelect = true;
          controller.betList.add(JcpBetModel(
              lotteryCode: controller.tickInfo.value.lotteryCode ?? '',
              playTypeCode: playInfo.cachePlayList?[0].playTypeCode ?? '',
              sonPlayTypeCode: playInfo.cachePlayList?[0].sonPlayTypeCode ?? '',
              playCode: playInfo.cachePlayList?[0].playCode ?? '',
              betContent: playInfo.cachePlayList?[0].playCode ?? '',
              betAmount: controller.numberController.text));
        } else {
          playInfo.cachePlayList?[0].isSelect = false;
          controller.betList.removeWhere((element) =>
          element.playCode == playInfo.cachePlayList?[0].playCode);
        }
        print('以选中选项：${JsonUtil.encodeObj(controller.betList)}');
      },
      child: Container(
        width: 70,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF2E374E),
            border: Border.all(width: 2,
                color: playInfo.cachePlayList?[0].isSelect ?? false ? Color(
                    0xFF755EFF) : Color(0xFF2E374E))),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildItemBall(String numString, List<Color> colors) {
    return Container(
      width: 28,
      height: 28,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [Colors.white, colors[0]],
        ),
        shape: OvalBorder(
          side: BorderSide(width: 2, color: colors[1]),
        ),
      ),
      child: Center(
        child: Text(
          numString,
          style: TextStyle(color: colors[2], fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSymbolView(String string) {
    return Container(
      width: 26,
      height: 26,
      child: Center(
        child: Text(
          string,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildLhcBall(String numString) {
    return Container(
      width: 28,
      height: 28,
      child: Stack(
        children: [
          Image.asset(
            controller.getLhcBallIcon(numString),
            width: 28,
            height: 28,
          ),
          Center(
            child: Text(
              numString,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

}