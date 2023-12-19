import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/common/models/bet_list_response_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/bet_list/widgets/bet_list_record_list_chid_view.dart';

import 'widgets/date_selection_section.dart';
import 'logic.dart';

final GlobalKey _buttonKey1 = GlobalKey();
final GlobalKey _buttonKey2 = GlobalKey();

class BetListPage extends StatefulWidget {
  const BetListPage({Key? key}) : super(key: key);

  @override
  State<BetListPage> createState() => _BetListPageState();
}

class _BetListPageState extends State<BetListPage> {
  final controller = Get.put(BetListController());
  final state = Get.find<BetListController>().state;

  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
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
                child:  GetBuilder<BetListController>(
                  builder: (controller){
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['全部类型','全部游戏'].asMap().map((index, value) {
                          return  MapEntry(
                              index,
                              Expanded(
                                child: Container(
                                    key: index == 0 ? _buttonKey1 : _buttonKey2,
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
                                        Text(value, style: TextStyle(color: Color(0xFF707A8C), fontSize: 12.sp, fontWeight: FontWeight.w400),),
                                        Image.asset('assets/images/mine/bet_list_down.png', width: 16.w, height: 16.w)
                                      ],
                                    )
                                ).onTap(() {
                                  if (index == 0) {
                                    List<String> gameTypeNames = controller.gameTypeModels.map((e) => e.name ?? "").toList();
                                    RenderBox renderBox = _buttonKey1.currentContext!.findRenderObject() as RenderBox;
                                    final buttonSize = renderBox.size;
                                    var child = GetBuilder<BetListController>(
                                        id: 'gameTypeMenu',
                                        builder: (controller){
                                      return Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: buttonSize.width,
                                          margin: EdgeInsets.only(top: 10.w),
                                          padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6.0),
                                            color: Color(0xFF222633),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: gameTypeNames.asMap().map((typeIndex, value) {
                                              var color = (controller.selectedGameTypeModel?.name ?? "") == value ? Color(0xFF5D5FEF) : Color(0xFF687083);
                                              return MapEntry(typeIndex, Text(
                                                  value,
                                                  style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w400)
                                              ).onTap(() {
                                                controller.onTapSwitchGameTyp(typeIndex);
                                              }));
                                            }).values.toList(),
                                          ),
                                        ),
                                      );
                                    });

                                    showOverlay(child, _buttonKey1);
                                  }
                                  else {
                                    List<String> gameTypeNames = controller.gameModels.map((e) => e.name ?? "").toList();
                                    RenderBox renderBox = _buttonKey2.currentContext!.findRenderObject() as RenderBox;
                                    final buttonSize = renderBox.size;
                                    var child = GetBuilder<BetListController>(
                                        id: 'gameMenu',
                                        builder: (controller){
                                          return Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              width: buttonSize.width,
                                              margin: EdgeInsets.only(top: 10.w),
                                              padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.0),
                                                color: Color(0xFF222633),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: gameTypeNames.asMap().map((typeIndex, value) {
                                                  var color = (controller.selectedGameModel?.name ?? "") == value ? Color(0xFF5D5FEF) : Color(0xFF687083);
                                                  return MapEntry(typeIndex, Text(
                                                      value,
                                                      style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w400)
                                                  ).onTap(() {
                                                    controller.onTapSwitchGame(typeIndex);
                                                  }));
                                                }).values.toList(),
                                              ),
                                            ),
                                          );
                                        });

                                    showOverlay(child, _buttonKey2);
                                  }
                                }),
                              )
                          );
                        }).values.toList(),
                      ),
                    );
                  },
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
                id: 'betList',
                builder: (controller) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            BetModel rowData = controller.betModels[index];
                            return BetListRecordListChidView(WBetListRecordListChidViewModel(
                                createTime: rowData.createTime,
                                gameName:rowData.gameName,
                                statusName:  rowData.gameWinStatusName,
                                money: rowData.gameProfit,
                                gameTypeName:  rowData.gameTypeName,
                                betAmount:  rowData.gameBet,
                                orderN: rowData.gameSn,
                                status:rowData.gameWinStatus
                            ));
                      },
                      childCount: controller.betModels.length
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

  late OverlayEntry overlayEntry;

  void showOverlay(Widget child, GlobalKey widgetKey) {

    RenderBox renderBox = widgetKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);

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
            left: buttonPosition.dx,
            top: buttonPosition.dy + buttonSize.height,
            child: child,
          ),
        ],
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
  }

  @override
  void dispose() {
    Get.delete<BetListController>();
    super.dispose();
  }
}