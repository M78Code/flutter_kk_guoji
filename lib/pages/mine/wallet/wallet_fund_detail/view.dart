import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_fund_detail/widgets/recharge_section.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_fund_detail/widgets/transaction_list_section.dart';

import '../../../../generated/assets.dart';
import '../../bet_list/widgets/custom_date_picker.dart';
import '../../bet_list/widgets/date_selection_section.dart';
import '../index/widgets/mine_wallet_balance_widget.dart';
import 'logic.dart';
import 'package:intl/intl.dart';

class WalletFundDetailPage extends StatefulWidget {
  const WalletFundDetailPage({Key? key}) : super(key: key);

  @override
  State<WalletFundDetailPage> createState() => _WalletFundDetailPageState();
}

class _WalletFundDetailPageState extends State<WalletFundDetailPage> {
  final controller = Get.put(WalletFundDetailLogic());
  late OverlayEntry overlayEntry;

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
        child:EasyRefresh(
          controller: controller.refreshController,
          onRefresh: () async {
            controller.onRefresh();
          },
          onLoad: () async {
            controller.onLoading();
          },
          child:  CustomScrollView(
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
                child: GetBuilder<WalletFundDetailLogic>(
                  id: 'dateSelector',
                  builder: (controller) {
                    String? dateRange;
                    if (controller.startDate != null && controller.endDate != null) {
                      var startText = DateFormat('MM/dd').format(controller.startDate!);
                      var endText = DateFormat('MM/dd').format(controller.endDate!);
                      dateRange = startText + " - " + endText;
                    }
                    return DateSelectionSection(
                        dateTypes: controller.dateTypes,
                        selectType: controller.dateType ?? "",
                        selectDateRange: dateRange,
                        onTap: (selectType){
                          controller.onTapSwitchDate(selectType);
                        },
                        onTapSelectTime: (){
                          _showTimeWidget();
                        });
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 15.w,)
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.w)),
              controller.userMoneyDetailsSearchList.isEmpty ? SliverToBoxAdapter(child: Center(
                child: Image.asset("assets/images/rebate/nodata.png", width: 200.w, height: 223.w,),
              )) :
              TransactionListSection(),
            ],
          ),
        ),
      ).safeArea(),
    );
  }
  void _showTimeWidget() {
    Widget child = CustomDatePicker(
      startDate: controller.startDate ?? DateTime.now(),
      endDate: controller.endDate ?? DateTime.now(),
      cancelAction: () {
        overlayEntry.remove();
      },
      dateConfirmAction: (startDate, endDate) {
        controller.switchDate(startDate, endDate);
        overlayEntry.remove();
      },
    );
    RenderBox renderBox = dateSelectionSectionKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    showOverlay(child, buttonPosition.dx, buttonPosition.dy + buttonSize.height);
  }

  void showOverlay(Widget child, double left,double top) {
    overlayEntry = OverlayEntry(
      builder: (context) =>
          Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    // Remove the overlay when tapped outside the image
                    overlayEntry.remove();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: child,
              ),
            ],
          ),
    );
    Overlay.of(context)?.insert(overlayEntry);
  }
}
