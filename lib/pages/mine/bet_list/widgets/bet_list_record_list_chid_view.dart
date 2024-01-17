import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/generated/assets.dart';



class WBetListRecordListChidViewModel {
  String? createTime;
  String? gameName;
  String? gameTypeName;
  String? betAmount;
  String? gameProfit;
  String? orderN;
  String? money;
  String? statusName;
  int? status;

  WBetListRecordListChidViewModel({this.createTime,
    this.gameName,
    this.gameTypeName,
    this.betAmount,
    this.gameProfit,
    this.orderN,
    this.money,
    this.statusName,
    this.status});
}


class BetListRecordListChidView extends StatelessWidget {
  final WBetListRecordListChidViewModel rowData;

  BetListRecordListChidView(this.rowData);

  @override
  Widget build(BuildContext context) {
    var index = -1;

    return Container(
      // height: 160.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rowData.createTime ?? "",
                    style: TextStyle(
                        color: Color(0x66FFFFFF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.w,),
                  Text(
                    rowData.gameName ?? "",
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  )

                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.w),
            decoration: BoxDecoration(
              color: Color(0x61222633),
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        _buildRecordItem('游戏类型',rowData.gameTypeName ?? ""),
                        _buildRecordItem('投注金额', rowData.betAmount ?? ""),
                        _buildRecordItem('注单号',rowData.orderN ?? "")
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                    child: Column(
                      children: [
                        Image.asset(
                          rowData.status == 0 ? Assets.mineBetListLose : (rowData.status == 1 ? Assets.mineBetListWin : Assets.mineBetListPreDraw),
                          width: 36.w,
                          height: 36.w,),
                        SizedBox(height: 4.w),
                        Text(
                          rowData.gameProfit ?? "",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecordItem(String title, String subTitle) {
    return Container(
      height: 20.w,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xFFB2B3BD),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ).width(60.w),
          Expanded(
              child:FittedBox(
                alignment: Alignment.topLeft,
                fit: BoxFit.contain,
                child: Text(
                  subTitle,
                  style: TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
          )
        ],
      ),
    );
  }
}


