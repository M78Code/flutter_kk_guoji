import 'package:flutter/material.dart';
import 'package:kkguoji/generated/assets.dart';

class WelfareList extends StatelessWidget {
  const WelfareList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
          color: const Color(0xFF222633),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Positioned(
                    left: 22,
                    top: 24,
                    child: Row(
                      children: [
                        Text(
                          '每日任务',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '活动',
                          style: TextStyle(
                              color: Color(0xFF686F83),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
                const SizedBox(height: 4),
                const Text(
                  '活动',
                  style: TextStyle(
                      color: Color(0xFF686F83),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        '游戏',
                        style: TextStyle(
                            color: Color(0xFF686F83),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '电子',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                  child: Row(
                    children: [
                      Text(
                        '游戏',
                        style: TextStyle(
                            color: Color(0xFF686F83),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '电子',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Positioned(
                  bottom: 20,
                  child: Container(
                    height: 45,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '去充值',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Positioned(
            top: 10,
            right: 0,
            child: Image.asset(
              Assets.imagespherosome,
              width: 121,
              height: 121,
            ),
          )
        ],
      ),
    );
  }
}
