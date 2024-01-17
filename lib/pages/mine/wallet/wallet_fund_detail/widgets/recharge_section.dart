import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../logic.dart';

class RechargeSection extends StatelessWidget {

  List<List<String>> items = [['充值金额', '88,686.00'],['提现金额', '88,686.00'],['我的返水', '88,686.00'],['推广返佣', '88,686.00'],['会员礼金', '88,686.00'],['活动金额', '88,686.00']];

  // 计算 childAspectRatio 的函数
  double calculateChildAspectRatio(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width - 24.w;
    double itemWidth = (totalWidth - 20.w) / 3;
    double childAspectRatio = itemWidth / 64.w;
    return childAspectRatio;
  }


  @override
  Widget build(BuildContext context) {
    // 获取计算得到的 childAspectRatio
    double childAspectRatio = calculateChildAspectRatio(context);

    return GetBuilder<WalletFundDetailLogic>(
      id: 'userMoneyDetails',
      builder: (controller){
        return Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
              childAspectRatio: childAspectRatio, // 使用计算得到的值

            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {

             List moneys = [controller.userMoneyDetailsModel?.totalRecharge ?? "",
                controller.userMoneyDetailsModel?.totalWithdraw ?? "",
                controller.userMoneyDetailsModel?.totalRebate ?? "",
                controller.userMoneyDetailsModel?.agentCommissTotal ?? "",
                controller.userMoneyDetailsModel?.totalGif ?? "",
                controller.userMoneyDetailsModel?.totalBonus ?? ""];

              return RechargeItem(items[index][0],moneys[index]);
            },
          ),
        );
      }
    );
  }
}
class RechargeItem extends StatelessWidget {
  final String title;
  final String subTitle;

  RechargeItem(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.w),
        color: Color(0x1F6A6CB2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w300),
            ),
            SizedBox(width: 4,),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: subTitle,
                        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}