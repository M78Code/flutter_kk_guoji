import 'package:flutter/material.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/message/message_model.dart';

class MeeageListView extends StatelessWidget {
  const MeeageListView({super.key, required MessageModel messageModel});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final MessageModel messageModel;

    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 15),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
          color: const Color(0xFF222633),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Positioned(
                  child: Text(
                    '2023-11-17 16:53:23',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 5),
                const Positioned(
                  child: Text(
                    '注册成功，欢迎加入本平台',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 5),
                const Positioned(
                  child: Text(
                    '尊敬的asdasd1231 ：恭喜您已经成为本平台正式会员。本平台拥有欧洲马耳他MGA、菲律宾政府\n(PAGCOR) 颁发的合法执照。注册 于英属维尔京群岛，是受国际行业协会认可的合法公司，选择本平台将为您的账号和资',
                    style: TextStyle(
                        color: Color(0xFF686F83),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 10),
                Positioned(
                  child: GestureDetector(
                    child: Row(
                      children: [
                        const Expanded(child: Text('')), //用这个设置在右边
                        const Text(
                          '显示所有',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          'assets/images/icon_down.png',
                          width: 12,
                          height: 12,
                        ),
                        //icon_up
                      ],
                    ),
                    onTap: () {
                      print('显示所有');
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Positioned(
                  child: Divider(
                    color: Color.fromRGBO(255, 255, 255, 0.06),
                    height: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Positioned(
                  child: GestureDetector(
                    child: Row(
                      children: [
                        const Text(
                          'https//: www.kkinternational.com',
                          style: TextStyle(
                              color: Color(0xFF5D5FEF),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const Expanded(child: Text('')), //用这个设置左右一个
                        Image.asset(
                          Assets.imagesIconArrowsBlue,
                          width: 18,
                          height: 18,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
