import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';


class WalletRecordBalanceWidget extends StatelessWidget {
  WalletRecordBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return GetBuilder<WalletRecordLogic>(
      id: 'userMoneyDetails',
      builder: (controller) {
        return Container(
          height: 64.w,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildButton('充值金额', controller.userMoneyDetailsModel?.totalRecharge ?? "0.00").expanded(),
              SizedBox(width: 10,),
              _buildButton('提现金额', controller.userMoneyDetailsModel?.totalWithdraw ?? "0.00").expanded(),
            ],
          ),
        );
      },
    );
  }

  Container _buildButton(String title, String subTitle) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x1F6A6CB2),
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 4.w,),
          RichText(text: TextSpan(
            children: [

              TextSpan(
                text: subTitle,
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
