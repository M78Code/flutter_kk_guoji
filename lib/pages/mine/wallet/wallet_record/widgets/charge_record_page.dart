import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/record_date_selectiong_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_balance_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_list.dart';

import '../logic.dart';

class ChargeRecordPage extends StatelessWidget {
  ChargeRecordPage({Key? key}) : super(key: key);
  final controller = Get.put(WalletRecordLogic());

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {
    return Scaffold(
      body:  EasyRefresh(
        controller: controller.userRechargeState.refreshController,
        onRefresh: () async {
          controller.onRefresh();
        },
        onLoad: () async {
          controller.onLoading();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: WalletRecordBalanceWidget().marginOnly(top: 10.w),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 20.w,)
              ),
              SliverToBoxAdapter(
                child: RecordDateSelectionWidget(builderId: 'rechargeDateSelector',),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 15.w,)
              ),
              WalletRecordList(isWithDrawRecord: false),
              SliverToBoxAdapter(
                  child: SizedBox(height: 10.w,)
              ),
            ],
          ),
        ).safeArea(),
      ),
    );
  }

}
