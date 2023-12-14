import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:flutter/material.dart';

class ChargeRecordListChild extends StatelessWidget {
  final List<String> rowData;

  ChargeRecordListChild(this.rowData);

  @override
  Widget build(BuildContext context) {

    return _buildView();
  }

  Container _buildView() {
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
                SizedBox(height: 10.w,),
                Text(
                  '订单号：20231112000892658924',
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.w,),
                Text(
                  '支付宝充值',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.w,),
                Text(
                  '2023-11-11 11:59:32',
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '成功',
                  style: TextStyle(
                      color: Color(0xFF74CC7D),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.w,),
                Text(
                  '-1000',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 14.w,),
        Divider(height: 1,color: Color(0x66FFFFFF),).opacity(0.1),
      ],
    ),
  );
  }
}


