import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:flutter/material.dart';



class WithdrawRecordListChildViewModel {
  String? createTime;
  String? type;
  String? bankUsername;
  String? bankNumber;
  String? orderN;
  int? money;
  String? statusName;

  WithdrawRecordListChildViewModel({this.createTime,
    this.type,
    this.bankUsername,
    this.bankNumber,
    this.orderN,
    this.money,
    this.statusName});
}


class WithdrawRecordListChild extends StatelessWidget {
  final WithdrawRecordListChildViewModel rowData;

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
                    rowData.createTime ?? "",
                    style: TextStyle(
                        color: Color(0x66FFFFFF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.w,),
                  Text(
                    rowData.type ?? "",
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
                    rowData.statusName ?? "",
                    style: TextStyle(
                        color: Color(0xFF74CC7D),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4.w,),
                  Text(
                    (rowData.money ?? 0).toString(),
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
                _buildRecordItem('提现人姓名',rowData.bankUsername ?? ""),
                SizedBox(height: 8.w,),
                _buildRecordItem('到账账号', rowData.bankNumber ?? ""),
                SizedBox(height: 8.w,),
                _buildRecordItem('订单号',rowData.orderN ?? ""),
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


