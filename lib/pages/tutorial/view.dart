import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/tutorial/widget/image_view.dart';
import 'package:kkguoji/pages/tutorial/widget/video_view.dart';

import '../../generated/assets.dart';
import '../../widget/custome_app_bar.dart';
import 'logic.dart';

class TutorialPage extends GetView<TutorialLogic> {
  TutorialPage({Key? key}) : super(key: key);

  final logic = Get.find<TutorialLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const KKCustomAppBar("新手充值USDT教程"),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _buildTabView(),
                _buildLineView(),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 25),
                  child: Text(
                    '您可以在数字币交易所内，使用银行卡直接购买数字货币，此教程以欧易交易所为例，讲解整个购买流程。',
                    style: TextStyle(
                      color: Color(0xFFB7C1DA),
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 5),
                  child: Text(
                    '*注：以下操作必须使用VPN链接海外节点进行，否则无法操作。',
                    style: TextStyle(
                      color: Color(0xFFFF3D00),
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return Stack(
                    children: [
                      Visibility(visible: logic.selectImage.value == 0, child: TutorialImageView()),
                      Visibility(visible: logic.selectImage.value == 1, child: TutorialVidoView()),
                    ],
                  );
                }),
              ],
            ),
          ),
        ));
  }

  Widget _buildTabView() {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: InkWell(
                onTap: () {
                  logic.selectImage.value = 0;
                },
                child: Container(
                  height: 35,
                  margin: EdgeInsets.only(left: 12, right: 5, top: 24, bottom: 14),
                  child: Obx(() {
                    return Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: logic.selectImage.value == 0 ? Colors.transparent : Color(0xFF222633),
                        shape: logic.selectImage.value == 0
                            ? RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF3D35C6)),
                          borderRadius: BorderRadius.circular(40),
                        )
                            : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.homeTutorialImage,
                            width: 23,
                            height: 23,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '图文教程',
                            style: TextStyle(
                              color: logic.selectImage.value == 0 ? Colors.white : Color(0xFF70798B),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              )),

          Expanded(
              child: InkWell(
                onTap: () {
                  logic.selectImage.value = 1;
                },
                child: Obx(() {
                  return Container(
                    height: 35,
                    margin: EdgeInsets.only(left: 5, right: 12, top: 24, bottom: 14),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: logic.selectImage.value == 1 ? Colors.transparent : Color(0xFF222633),
                        shape: logic.selectImage.value == 1
                            ? RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF3D35C6)),
                          borderRadius: BorderRadius.circular(40),
                        )
                            : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.homeTutorialVideo,
                            width: 23,
                            height: 23,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '视频教程',
                            style: TextStyle(
                              color: logic.selectImage.value == 1 ? Colors.white : Color(0xFF70798B),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }

  Widget _buildLineView() {
    return Opacity(
        opacity: 0.06,
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.white,
        ));
  }
}
