import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:flutter/material.dart';

class WithdrawRecordListChild extends StatelessWidget {
  final List<String> rowData;

  WithdrawRecordListChild(this.rowData);

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
                    '2023-11-11 11:59:32',
                    style: TextStyle(
                        color: Color(0x66FFFFFF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.w,),
                  Text(
                    'CNPL提现',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  )

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
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.w),
            decoration: BoxDecoration(
              color: Color(0x61222633),
              borderRadius: BorderRadius.all(Radius.circular(6.w)),
            ),
            child: Column(
              children: [
                _buildRecordItem('提现人姓名','张三丰'),
                SizedBox(height: 8.w,),
                _buildRecordItem('到账账号','张三丰'),
                SizedBox(height: 8.w,),
                _buildRecordItem('订单号','张三丰'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _buildRecordItem(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0xFFB2B3BD),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        ),
        Text(
          subTitle,
          style: TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}


