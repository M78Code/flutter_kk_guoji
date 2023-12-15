import 'package:flutter/material.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_list_child.dart';

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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              List<String> rowData = transactions[index];
              return this.isWithDrawRecord ?
              WithdrawRecordListChild(rowData) : ChargeRecordListChild(rowData);
        },
        childCount:transactions.length,
      ),
    );
  }
}

