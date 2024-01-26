import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kkguoji/common/extension/index.dart';

import '../../../../../generated/assets.dart';
import '../../../../../routes/routes.dart';
import '../../../../../services/user_service.dart';
import '../../../../../utils/route_util.dart';


class MineWalletBalanceWidget extends StatelessWidget {
  MineWalletBalanceWidget({Key? key}) : super(key: key);
  static var kHeight = 74.w;

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Container(
      height: 74.w,
      decoration: BoxDecoration(
        color: Color(0xFF2E374C).withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '钱包余额',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              Obx(() {
                return RichText(text: TextSpan(
                  children: [
                    // TextSpan(
                    //   text: "¥",
                    //   style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.bold),
                    // ),
                    TextSpan(
                      text: UserService.to.userMoneyModel?.money ?? "0.00",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
              }),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('充值', Assets.mineWalletSaving, () {
                RouteUtil.pushToView(Routes.recharge, arguments: true);
              }),
              SizedBox(width: 10.w),
              _buildButton('提现', Assets.mineWalletWithdraw, () {
                RouteUtil.pushToView(Routes.withdraw, arguments: true);
              }),
              SizedBox(width: 15.w),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String title,String image, Function onTap) {
    return Container(
      height: 40.w,
      width: 86.w,
      decoration: BoxDecoration(
        color: const Color(0xFF2D374E),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 25.w,
            height: 25.w,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ).onTap(() {
      onTap.call();
    });
  }
}
