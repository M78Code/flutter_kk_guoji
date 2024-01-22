import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_list_child.dart';

import '../../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import '../../../../../generated/assets.dart';
import 'charge_record_list_child.dart';

class WalletRecordList extends StatelessWidget {

  final bool isWithDrawRecord;

  WalletRecordList({required this.isWithDrawRecord});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletRecordLogic>(
      builder: (controller) {
        if ( this.isWithDrawRecord  && controller.userWithdrawState.userWithdrawModels.isEmpty) {
          return SingleChildScrollView(
            child: Center(child: Image.asset(Assets.rebateNodata, width: 200.w, height: 223.w,)),
          ).expanded();
        } else if ( this.isWithDrawRecord == false  && controller.userRechargeState.userRechargeModels.isEmpty) {
          return SingleChildScrollView(
            child: Image.asset(Assets.rebateNodata, width: 200.w, height: 223.w,),
          );
        }
        var listView = ListView.builder(
          key: this.isWithDrawRecord ? ValueKey("WithDrawRecord_$controller.userWithdrawState.dateType") : ValueKey("RechargeRecord_$controller.userWithdrawState.dateType"),
          itemCount: this.isWithDrawRecord ? controller.userWithdrawState.userWithdrawModels.length :  controller.userRechargeState.userRechargeModels.length,
            itemBuilder: (context, index) {
            if ( this.isWithDrawRecord) {
              UserWithdrawModel userWithdrawModel = controller.userWithdrawState.userWithdrawModels[0];
              var viewModel = WithdrawRecordListChildViewModel(
                  createTime: userWithdrawModel.createTime,
                  type: userWithdrawModel.type,
                  statusName: userWithdrawModel.statusName,
                  money: userWithdrawModel.money,
                  bankUsername: userWithdrawModel.bankUsername,
                  bankNumber: userWithdrawModel.bankNumber,
                  orderN: userWithdrawModel.sn);
              return WithdrawRecordListChild(viewModel);
            }
            else {
              UserRechargeModel userRechargeModel = controller.userRechargeState.userRechargeModels[0];
              var viewModel = RechargeRecordListChildViewModel(
                orderN: userRechargeModel.sn,
                createTime: userRechargeModel.createTime,
                payName: userRechargeModel.payName,
                money: userRechargeModel.money,
                status_name:  userRechargeModel.statusName,
              );
              return  ChargeRecordListChild(viewModel);
            }
          },
        );
        return listView;
      },
    );
  }
}

