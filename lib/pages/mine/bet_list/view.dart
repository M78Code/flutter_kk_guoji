import 'dart:ffi';
import 'dart:math';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/common/models/bet_list_response_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/bet_list/widgets/bet_list_menu_widget.dart';
import 'package:kkguoji/pages/mine/bet_list/widgets/bet_list_record_list_chid_view.dart';
import 'package:kkguoji/pages/mine/bet_list/widgets/custom_date_picker.dart';

import '../../../services/user_service.dart';
import 'widgets/date_selection_section.dart';
import 'logic.dart';
import 'package:intl/intl.dart';


class BetListPage extends StatefulWidget {
  const BetListPage({Key? key}) : super(key: key);

  @override
  State<BetListPage> createState() => _BetListPageState();
}

class _BetListPageState extends State<BetListPage> {
  final controller = Get.put(BetListController());
  final state = Get.find<BetListController>().state;

  late OverlayEntry overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BetListController>(
      id: 'betListPage',
      builder: (controller){
        return _buildView();
      },
    );
  }
  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('游戏记录'),
        leading:  IconButton(
          icon: Image.asset(
              Assets.systemIconBack,
              width: 20.w,
              height: 20.w),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          RichText(text: TextSpan(
            children: [
              TextSpan(
                text: UserService.to.userMoneyModel?.money ?? "0.00",
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          )).marginOnly(right: 14.sp),
        ],
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
                  id: 'menu',
                  builder: (controller){
                    return BetListMenuWidget(
                        menuTexts: [controller.selectedGameTypeModel.name ?? "",controller.selectedGameModel.name ?? ""],
                        onTap: (index){
                          if (index == 0) {
                            _typeMenuCli(controller);
                          }
                          else {
                            _gameMenuCli(controller);
                          }
                        });
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.w,)),
              SliverToBoxAdapter(
                child: GetBuilder<BetListController>(
                  id: 'dateSelector',
                  builder: (_) {
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
                          _showTimeWidget(controller);
                        });
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.w)),
              controller.betModels.isEmpty ? SliverToBoxAdapter(child: Center(
                child: Image.asset("assets/images/rebate/nodata.png", width: 200.w, height: 223.w,),
              )) : _buildList()
              // TransactionListSection(),
            ],
          ),
        ),
      ).safeArea(),
    );
  }

  GetBuilder<BetListController> _buildList() {
    return GetBuilder<BetListController>(
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
    );
  }

  void _gameMenuCli(BetListController controller) {

    controller.gameSearchKey = "";
    var searchWidget = Container(
      height: 33.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.w),
        color: Color(0xFF1A1E2A),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color:Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: '搜索游戏',
                  hintStyle: TextStyle(color:Color(0x33FFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400),
                  border: InputBorder.none, // 去掉外框
                ),
                onChanged: (text) {
                    controller.gameSearchKeyChange(text);
                },
              ),
            ),
            Image.asset(
                Assets.mineWalletSearch,
                width: 29.w,
                height: 29.w)
                .marginOnly(right: 12.w),
          ]),
    );

    RenderBox renderBox = menuButtonKey2.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    var child = GetBuilder<BetListController>(
        id: 'gameMenu',
        builder: (controller){
          var searchResult = controller.gameModels.where((element) => element.name?.contains(controller.gameSearchKey) ?? true).toList();
          var widgets = searchResult.asMap().map((typeIndex, gameModel) {
            var color = controller.selectedGameModel.id == gameModel.id ? Color(0xFF5D5FEF) : Color(0xFF687083);
            return MapEntry(
                typeIndex,
                Container(
                    height: 30.w,
                    child: Text(gameModel.name ?? '', style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w400),
                    )
                ).onTap(() {
                  controller.onTapSwitchGame(gameModel);
                  overlayEntry.remove();
                })
            );
          }).values.toList();
          return Material(
            color: Colors.transparent,
            child: Container(
              width: buttonSize.width,
              margin: EdgeInsets.only(top: 10.w),
              padding:  EdgeInsets.symmetric(vertical: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Color(0xFF222633),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchWidget,
                  SizedBox(height: 20.w,),
                  Container(
                    height: min(240.w, widgets.length * 30.w),
                    child: SingleChildScrollView(
                      child: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widgets,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    showOverlay(child, buttonPosition.dx, buttonPosition.dy + buttonSize.height);
  }

  void _typeMenuCli(BetListController controller) {
    RenderBox renderBox = menuButtonKey1.currentContext!.findRenderObject() as RenderBox;
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
                children: controller.gameTypeModels.asMap().map((typeIndex, gameTypeModel) {
                  var color = controller.selectedGameTypeModel.id == gameTypeModel.id ? Color(0xFF5D5FEF) : Color(0xFF687083);
                  return MapEntry(
                      typeIndex,
                      Container(
                        height: 30.w,
                        child: Text(gameTypeModel.name ?? '', style: TextStyle(color: color, fontSize: 13.sp, fontWeight: FontWeight.w400),
                      )
                  ).onTap(() {
                    controller.onTapSwitchGameTyp(typeIndex);
                    overlayEntry.remove();
                  }));
                }).values.toList(),
              ),
            ),
          );
        });

    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    showOverlay(child, buttonPosition.dx, buttonPosition.dy + buttonSize.height);
  }

  void _showTimeWidget(BetListController controller) {
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

  @override
  void dispose() {
    Get.delete<BetListController>();
    super.dispose();
  }
}
