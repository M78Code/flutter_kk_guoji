import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_page.dart';

import '../../../../generated/assets.dart';
import 'widgets/charge_record_page.dart';
import 'logic.dart';

class WalletRecordPage extends StatelessWidget {
  WalletRecordPage({Key? key}) : super(key: key);

  final controller = Get.put(WalletRecordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _buildSwitchMenu(),
          leading:  IconButton(
            icon: Image.asset(
                Assets.systemIconBack,
                width: 20.w,
                height: 20.w),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body:Container(
          child:  PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.switchIndex(index);
            },
            children: [
              WithdrawRecordPage(),
              ChargeRecordPage()
            ],
          ),
        )
    );;
  }

  Widget _buildView() {
    return Container(
      child: Expanded(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.switchIndex(index);
            },
            children: [
              WithdrawRecordPage(),
              ChargeRecordPage()
            ],
          )
      ),
    );
  }
  Widget _buildSwitchMenu() {

    var selTextStyle = TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700);
    var unselTextStyle = TextStyle(color: Color(0x66FFFFFF), fontSize: 18.sp, fontWeight: FontWeight.w400);

    return GetBuilder<WalletRecordLogic>(
      id: 'menu',
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('提现记录',
                    style: controller.currentIndex == 0 ? selTextStyle : unselTextStyle),
                SizedBox(height: 10.w,),
                if(controller.currentIndex == 0)  Image.asset(Assets.mineWalletNavArrow,width: 25.w, height: 4.w,)
              ],
            ).onTap(() {
              controller.menuOntap(0);
            }),
            SizedBox(width: 10.w,),
            Column(
              children: [
                Text('充值记录',
                    style: controller.currentIndex == 1 ? selTextStyle : unselTextStyle),
                SizedBox(height: 10.w,),
                if(controller.currentIndex == 1) Image.asset(Assets.mineWalletNavArrow,width: 25.w, height: 4.w,)
              ],
            ).onTap(() {
              controller.menuOntap(1);
            }),
            SizedBox(width: 52.w,),
          ],
        );
      },
    );
  }
}
