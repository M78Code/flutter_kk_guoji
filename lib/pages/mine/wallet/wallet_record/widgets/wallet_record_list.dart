import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_list_child.dart';

import '../../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import 'charge_record_list_child.dart';

class WalletRecordList extends StatelessWidget {

  final bool isWithDrawRecord;

  WalletRecordList({required this.isWithDrawRecord});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletRecordLogic>(
      builder: (controller) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {

                  if ( this.isWithDrawRecord) {
                    UserWithdrawModel userWithdrawModel = controller.userWithdrawState.userWithdrawModels[index];
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
                    UserRechargeModel userRechargeModel = controller.userRechargeState.userRechargeModels[index];
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
            childCount: this.isWithDrawRecord ? controller.userWithdrawState.userWithdrawModels.length :  controller.userRechargeState.userRechargeModels.length,
          ),
        );
      },
    );
  }
}

