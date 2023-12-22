
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_balance_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_list.dart';

import '../../../bet_list/widgets/custom_date_picker.dart';
import '../../../bet_list/widgets/date_selection_section.dart';
import 'package:intl/intl.dart';

class WithdrawRecordPage extends StatelessWidget {
  WithdrawRecordPage({Key? key}) : super(key: key);
  final controller = Get.put(WalletRecordLogic());
  late OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
  Widget _buildView(BuildContext context) {
    return Scaffold(
      body:  EasyRefresh(
        controller: controller.userWithdrawState.refreshController,
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
                child: GetBuilder<WalletRecordLogic>(
                  id: 'withdrawDateSelector',
                  builder: (controller) {
                    String? dateRange;
                    if (controller.userWithdrawState.startDate != null && controller.userWithdrawState.endDate != null) {
                      var startText = DateFormat('MM/dd').format(controller.userWithdrawState.startDate!);
                      var endText = DateFormat('MM/dd').format(controller.userWithdrawState.endDate!);
                      dateRange = startText + " - " + endText;
                    }
                    return DateSelectionSection(
                        dateTypes: controller.userWithdrawState.dateTypes,
                        selectType: controller.userWithdrawState.dateType ?? "",
                        selectDateRange: dateRange,
                        onTap: (selectType){
                          controller.onTapSwitchDate(selectType);
                        },
                        onTapSelectTime: (){
                          _showTimeWidget(context);
                        });
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 15.w,)
              ),
              controller.userWithdrawState.userWithdrawModels.isEmpty ? SliverToBoxAdapter(child: Center(
                child: Image.asset("assets/images/rebate/nodata.png", width: 200.w, height: 223.w,),
              )) :
              WalletRecordList(isWithDrawRecord: true),
              SliverToBoxAdapter(
                  child: SizedBox(height: 10.w,)
              ),
            ],
          ),
        ).safeArea(),
      ),
    );
  }

  void _showTimeWidget(BuildContext context) {
    var startDate = controller.currentIndex == 0 ? controller.userWithdrawState.startDate : controller.userWithdrawState.startDate;
    var endDate = controller.currentIndex == 0 ? controller.userWithdrawState.endDate : controller.userWithdrawState.endDate;

    Widget child = CustomDatePicker(
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
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
    showOverlay(child, buttonPosition.dx, buttonPosition.dy + buttonSize.height, context);
  }

  void showOverlay(Widget child, double left,double top, BuildContext context) {
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
