import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/generated/assets.dart';

class HomeServeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "服务优势",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 15,
          ),
          _buildServeItem('极速存取转款', '自主研发的财务处理系统真正做到极速存、取、转独家网络优化技术。', Assets.homeServeOne),
          SizedBox(
            height: 10,
          ),
          _buildServeItem('专业公正的彩票结果', '专注于彩票游戏行业多年，拥有经典彩种，超多独家创新玩法，只为公平、公正的开奖结果。', Assets.homeServeTwo),
          SizedBox(
            height: 10,
          ),
          _buildServeItem('加密安全管理', '独家开发，采用128位加密技术和严格的安全管理体系，让您全情尽享娱乐、无后顾之忧！', Assets.homeServeThree),
          SizedBox(
            height: 10,
          ),
          _buildServeItem('三端任您选择', '引领市场的卓越技术，自主研发了全套终端应用，让您随时随地，娱乐投注随心所欲！', Assets.homeServeFour),
          SizedBox(
            height: 30,
          ),
          Text(
            "资质认证",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          _buildZZItem(),
        ],
      ),
    );
  }

  Widget _buildZZItem() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.homeServePagcor,
            width: 98,
            height: 28,
          ),
          Text(
            '菲律宾（PAGCOR）监督竞猜牌照',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFB2B3BD),
              fontSize: 10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.homeServeMga,
                    width: 98,
                    height: 28,
                  ),
                  Text(
                    '马耳他牌照（MGA）认证',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFB2B3BD),
                      fontSize: 10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 60,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.homeServeFsc,
                    width: 98,
                    height: 28,
                  ),
                  Text(
                    '英属维尔京群岛（BVI）认证',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFB2B3BD),
                      fontSize: 10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 60,),
        ],
      ),
    );
  }

  Widget _buildServeItem(String title, String content, String imageAsset) {
    return Container(
      width: Get.width,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(0.5),
              width: Get.width - 25,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3D35C6), // 渐变色的开始颜色
                    Color(0xFF0F1921), // 渐变色的结束颜色
                  ],
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF0F1921),
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            top: 28,
            child: Container(
              width: 44,
              height: 46,
              child: Image.asset(
                imageAsset,
                width: 44,
                height: 46,
              ),
            ),
          ),
          Positioned(
            left: 84,
            top: 32,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                        height: 0.01,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 248,
                    child: Text(
                      content,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xFF74739B),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
