import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_list_child.dart';

import '../../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import 'charge_record_list_child.dart';

class WalletRecordList extends StatelessWidget {

  final bool isWithDrawRecord;

  WalletRecordList({required this.isWithDrawRecord});

  List<List<String>> transactions = [
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
    ['2023-11-11\n11:59:32', '游戏下注', '-100', '1,686'],
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletRecordLogic>(
      id: 'searchList',
      builder: (controller) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {

                  if ( this.isWithDrawRecord) {
                    UserWithdrawModel userWithdrawModel = controller.userWithdrawModels[index];
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
              List<String> rowData = transactions[index];
              return  ChargeRecordListChild(rowData);
            },
            childCount:this.isWithDrawRecord ? controller.userWithdrawModels.length : transactions.length,
          ),
        );
      },
    );
  }
}

