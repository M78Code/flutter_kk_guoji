import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/bet_list/widgets/bet_list_record_list_chid_view.dart';

import 'widgets/date_selection_section.dart';
import 'logic.dart';

class BetListPage extends StatefulWidget {
  const BetListPage({Key? key}) : super(key: key);

  @override
  State<BetListPage> createState() => _BetListPageState();
}

class _BetListPageState extends State<BetListPage> {
  final controller = Get.put(BetListController());
  final state = Get.find<BetListController>().state;
  GlobalKey rowKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {

    var widgets = ['全部类型','全部游戏'].asMap().map((index, value) {
      return  MapEntry(
          index,
          Expanded(
            child: Container(
              margin: index == 1 ? EdgeInsets.only(left: 10.w) : null,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              height: 42.w,
              decoration: BoxDecoration(
                color: Color(0xFF222633),
                borderRadius: BorderRadius.circular(6.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('全部类型', style: TextStyle(color: Color(0xFF707A8C), fontSize: 12.sp, fontWeight: FontWeight.w400),),
                  Image.asset('assets/images/mine/bet_list_down.png', width: 16.w, height: 16.w)
                ],
              ),
            ).onTap(() {
              _showPopup(context);
            }),
          )
      );
    }).values.toList();

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
          // controller: controller.refreshController,
          onRefresh: () async {
            // controller.onRefresh();
          },
          onLoad: () async {
            // controller.onLoading();
          },
          child:  CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 15.w,)),
              SliverToBoxAdapter(
                child: Container(
                  key: rowKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widgets,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.w,)),
              SliverToBoxAdapter(
                child: GetBuilder<BetListController>(
                  id: 'dateSelector',
                  builder: (_) {
                    return DateSelectionSection(dateTypes: controller.dateTypes, selectType: controller.dateType, onTap: (selectType){
                      controller.onTapSwitchDate(selectType);
                    });
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(height: 15.w,)
              ),
              GetBuilder<BetListController>(
                id: 'searchList',
                builder: (controller) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // UserMoneyDetailsSearchModel rowData = controller.userMoneyDetailsSearchList[index - 1];
                            return BetListRecordListChidView(WBetListRecordListChidViewModel(
                                createTime: '2023', // userWithdrawModel.createTime,
                                type: '2023', // userWithdrawModel.type,
                                statusName: '2023', // userWithdrawModel.statusName,
                                money: int.parse('100'), // userWithdrawModel.money,
                                bankUsername: '2023' ,// userWithdrawModel.bankUsername,
                                bankNumber: '2023', // userWithdrawModel.bankNumber,
                                orderN: '2023' // userWithdrawModel.sn
                            ));
                      },
                      childCount: 10// controller.userMoneyDetailsSearchList.length + 1,
                    ),
                  );
                },
              )
              // TransactionListSection(),
            ],
          ),
        ),
      ).safeArea(),
    );
  }


  void _showPopup(BuildContext context) {
    double spacing = 10.0; // Adjust the spacing as needed
    RenderBox renderBox = rowKey.currentContext!.findRenderObject() as RenderBox;
    var rowTop = renderBox.localToGlobal(Offset.zero).dy;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Positioned(
          top:  11110,
          left: 0.0,
          right: 0.0,
          child: AlertDialog(
              alignment: Alignment.topLeft,
            title: Text('Popup Title'),
            content: Text('Popup Content'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    Get.delete<BetListController>();
    super.dispose();
  }
}