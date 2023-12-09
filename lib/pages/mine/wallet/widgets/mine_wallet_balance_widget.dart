import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';

class MineWalletBalanceWidget extends StatelessWidget {
  MineWalletBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
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
              const Text(
                '¥88,686.00',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('存款', Assets.mineWalletSaving, () {

              }),
              SizedBox(width: 10.w),
              _buildButton('提现', Assets.mineWalletWithdraw, () {

              }),
              SizedBox(width: 15.w),
            ],
          )
        ],
      ),
    );
  }
  Container _buildButton(String title,String image, Function onTap) {
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
    );
  }
}
