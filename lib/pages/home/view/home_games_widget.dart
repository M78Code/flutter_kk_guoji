import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/main/logic/main_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../logic/logic.dart';

class KKHomeGamesWidget extends StatelessWidget {
  KKHomeGamesWidget({super.key});

  final controller = Get.find<HomeLogic>();
  final mainController = Get.find<MainPageLogic>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "KK游戏",
                  style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 13),
                ),
                Text(
                  "KK推荐",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            InkWellView(
              onPressed: () => mainController.clickTabBarItem(1),
              child: const Row(
                children: [
                  Text(
                    "查看全部",
                    style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Icon(
                    Icons.chevron_right_outlined,
                    size: 24,
                    color: Color(0xFFB2B3BD),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: double.infinity,
          height: 236,
          child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 108 / 78.0, crossAxisSpacing: 10, mainAxisSpacing: 15),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    height: 118,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF24262F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          controller.recommendGameList[index].gameIcon,
                          height: 80,
                        ),
                        Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              controller.recommendGameList[index].gameName,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ))
                      ],
                    ),
                  ),
                  onTap: () {
                    controller.openTickGame();
                  },
                );
              }),
        ),
      ],
    );
  }
}
