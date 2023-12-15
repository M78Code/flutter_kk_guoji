import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/record_date_selectiong_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_balance_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_list.dart';

class WithdrawRecordPage extends StatelessWidget {
  WithdrawRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {
    return Scaffold(
      body:  Container(
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
              child: RecordDateSelectionWidget(),
            ),
            SliverToBoxAdapter(
                child: SizedBox(height: 15.w,)
            ),
            WalletRecordList(isWithDrawRecord: true),
            SliverToBoxAdapter(
                child: SizedBox(height: 10.w,)
            ),
          ],
        ),
      ).safeArea(),
    );
  }
}
