import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';

import '../../../../../common/models/mine_wallet/user_money_details_search_respond_model.dart';
import '../logic.dart';


class TransactionListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return GetBuilder<WalletFundDetailLogic>(
      id: 'searchList',
      builder: (controller) {
        if (controller.userMoneyDetailsSearchList.isEmpty) {
         return SliverToBoxAdapter(child: Center(child: Image.asset("assets/images/rebate/nodata.png", width: 200.w, height: 223.w,)));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              if (index == 0) {
                return TransactionHeaderRow();
              }
              else {
                UserMoneyDetailsSearchModel rowData = controller.userMoneyDetailsSearchList[index - 1];
                return TransactionDataRow(rowData);
              }
            },
            childCount:controller.userMoneyDetailsSearchList.length + 1,
          ),
        );
      },
    );
  }
}


class TransactionHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = ['时间','类型','收支','余额'].map((e) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          e,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFFB2B3BD),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300),
        ),
      ).expanded();
    }).toList();

    return Container(
      height: 30.w,
      color: Color(0x1F6A6CB2),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }
}

class TransactionDataRow extends StatelessWidget {
  final UserMoneyDetailsSearchModel rowData;

  TransactionDataRow(this.rowData);

  @override
  Widget build(BuildContext context) {
    var index = -1;
    List fontSizes = [11.w,12.w,14.w,14.w];
    List fontWeights = [FontWeight.w400,FontWeight.w400,FontWeight.w500,FontWeight.w500];

    List<Widget> widgets = [rowData.createTime ?? "",rowData.desc ?? "",rowData.incomeExpenses ?? "", rowData.afterMoney ?? ""].map((e) {
      ++index;
      var color = Color(0xFFFFFFFF);
      if (index == 2) {
        if (double.parse(rowData.incomeExpenses ?? "") > 0) {
          color = Color(0xFF74CC7D);
        }
        else if (double.parse(rowData.incomeExpenses ?? "") < 0) {
          color = Color(0xFFEE5D5D);
        }
      }
      return Container(
        child: Text(
          e,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color,
              fontSize: fontSizes[index],
              fontWeight: fontWeights[index]),
        ),
      ).expanded();
    }).toList();

    return Container(
      height: 50.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(height: 10,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widgets,
            ),
          ),
          Divider(height: 0.5,color: Color(0xFFFFFFFF).withOpacity(0.1),)
        ],
      ),
    );
  }
}

class TransactionCell extends StatelessWidget {
  final String text;

  TransactionCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }
}

