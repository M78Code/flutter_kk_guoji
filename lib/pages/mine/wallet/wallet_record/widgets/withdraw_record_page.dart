import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_balance_widget.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/wallet_record_list.dart';

import '../../../../../generated/assets.dart';
import '../../../bet_list/widgets/custom_date_picker.dart';
import '../../../bet_list/widgets/date_selection_section.dart';
import 'package:intl/intl.dart';

class WithdrawRecordPage extends StatelessWidget {
  WithdrawRecordPage({Key? key}) : super(key: key);
  final controller = Get.put(WalletRecordLogic());
  late OverlayEntry overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletRecordLogic>(
      id: "withdrawPage",
      builder: (_) {
        return _buildView(context);
      },
    );
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: EasyRefresh(
            controller: controller.userWithdrawState.refreshController,
            onRefresh: () async {
              controller.onRefresh();
            },
            onLoad: () async {
              controller.onLoading();
            },
            child: CustomScrollView(
              key: UniqueKey(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverHeaderDelegate(
                      10.w +
                          WalletRecordBalanceWidget.kHeight +
                          20.w +
                          DateSelectionSection.kHeight +
                          15.w,
                      child: ListView(
                        children: [
                          SizedBox(height: 10.w),
                          WalletRecordBalanceWidget(),
                          SizedBox(height: 20.w),
                          GetBuilder<WalletRecordLogic>(
                            id: 'withdrawDateSelector',
                            builder: (controller) {
                              String? dateRange;
                              if (controller.startDate != null && controller.endDate != null) {
                                var startText = DateFormat('MM/dd').format(controller.startDate!);
                                var endText = DateFormat('MM/dd').format(controller.endDate!);
                                dateRange = startText + " - " + endText;
                              }
                              return DateSelectionSection(
                                  dateTypes: controller.userWithdrawState.dateTypes,
                                  selectType: controller.dateType ?? "",
                                  selectDateRange: dateRange,
                                  onTap: (selectType) {
                                    controller.onTapSwitchDate(selectType);
                                  },
                                  onTapSelectTime: () {
                                    _showTimeWidget(context);
                                  });
                            },
                          ),
                          SizedBox(height: 15.w)
                        ],
                      )),
                ),
                WalletRecordList(isWithDrawRecord: true),
              ],
            ),
          )).safeArea(),
    );
  }

  void _showTimeWidget(BuildContext context) {
    var startDate = controller.startDate;
    var endDate = controller.endDate;

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

  void showOverlay(Widget child, double left, double top, BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
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

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;

  CustomSliverHeaderDelegate(this.maxHeight, {required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
      color: Theme.of(context).appBarTheme.backgroundColor,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => maxHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
