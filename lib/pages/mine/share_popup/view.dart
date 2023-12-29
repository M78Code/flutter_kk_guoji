import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';

import 'logic.dart';

class SharePopupPage extends StatefulWidget {
  const SharePopupPage({Key? key}) : super(key: key);

  @override
  State<SharePopupPage> createState() => _SharePopupPageState();
}

class _SharePopupPageState extends State<SharePopupPage> {
  final logic = Get.put(SharePopupLogic());
  final state = Get.find<SharePopupLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 46.w),
      child: Center(
        child: Column(
          children: [
            Container(
                height: 165.w,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset(logic.promotionModel?.image?.first ?? ""))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SharePopupLogic>();
    super.dispose();
  }
}