import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:flutter/material.dart';



class RechargeRecordListChildViewModel {
  String? orderN;
  String? payName;
  String? createTime;
  String? money;
  String? status_name;

  RechargeRecordListChildViewModel({this.createTime,
    this.payName,
    this.orderN,
    this.money,
    this.status_name});
}

class ChargeRecordListChild extends StatelessWidget {
  final RechargeRecordListChildViewModel rowData;

  ChargeRecordListChild(this.rowData);

  @override
  Widget build(BuildContext context) {

    return _buildView();
  }

  Container _buildView() {

    var moneyColor = (rowData.status_name ?? '').contains('成功') ? Color(0xFF74CC7D) :
    (rowData.status_name ?? '').contains('失败') ? Color(0xFFEE5D5D) : Color(0xFF687083);
    return Container(
    // height: 160.w,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '订单号：${rowData.orderN ?? ""}',
              style: TextStyle(color: Color(0x66FFFFFF),fontSize: 12.sp,fontWeight: FontWeight.w500)),
            Text(
              rowData.status_name ?? "",
              style: TextStyle(color: moneyColor,fontSize: 12.sp,fontWeight: FontWeight.w600)),// 失败 FFEE5D5D 处理中#FF687083
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rowData.payName ?? "",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.w,),
                Text(
                  rowData.createTime ?? "",
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              rowData.money ?? "",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        SizedBox(height: 10.w,),
        Divider(height: 1,color: Color(0x66FFFFFF),).opacity(0.1),
      ],
    ),
  );
  }
}


