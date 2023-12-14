import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_fund_detail/widgets/date_selection_section.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_fund_detail/widgets/recharge_section.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_fund_detail/widgets/transaction_list_section.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/assets.dart';
import '../index/widgets/mine_wallet_balance_widget.dart';
import 'logic.dart';

class WalletFundDetailPage extends StatelessWidget {
  WalletFundDetailPage({Key? key}) : super(key: key);

  final controller = Get.put(WalletFundDetailLogic());

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
      body:  Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          header: WaterDropHeader(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: MineWalletBalanceWidget(),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 20.w,)
              ),
              SliverToBoxAdapter(
                child: RechargeSection(),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 20.w,)
              ),
              SliverToBoxAdapter(
                child: DateSelectionSection(),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 15.w,)
              ),
              TransactionListSection(),
            ],
          ),
        ),
      ).safeArea(),
    );
  }


}
