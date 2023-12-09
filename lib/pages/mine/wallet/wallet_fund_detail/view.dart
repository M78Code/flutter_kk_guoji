import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../widgets/mine_wallet_balance_widget.dart';
import 'logic.dart';

class WalletFundDetailPage extends StatelessWidget {
  WalletFundDetailPage({Key? key}) : super(key: key);

  // final logic = Get.put(WalletFundDetailPage());

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('资产明细'),
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
      body: Container(
        child: Column(
            children: [
              SizedBox(height: 20.w,),
              MineWalletBalanceWidget(),

              Spacer(),
            ]
        ),
      ),
    );
  }
}
