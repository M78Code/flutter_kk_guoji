import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/logic.dart';
import 'package:kkguoji/pages/mine/wallet/wallet_record/widgets/withdraw_record_list_child.dart';

import '../../../../../common/models/mine_wallet/user_recharge_list_respond_model.dart';
import '../../../../../common/models/mine_wallet/user_withdraw_list_respond_model.dart';
import '../../../../../generated/assets.dart';
import 'recharge_record_list_child.dart';

class WalletRecordList extends StatelessWidget {

  final bool isWithDrawRecord;
  final controller = Get.put(WalletRecordLogic());

  WalletRecordList({required this.isWithDrawRecord});

  @override
  Widget build(BuildContext context) {
    var userWithdrawModels = this.isWithDrawRecord ? controller.userWithdrawState.userWithdrawModels : controller.userRechargeState.userRechargeModels;
    return SliverList(
      key: UniqueKey(),
      delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (userWithdrawModels.isEmpty) {
                  return Container(child: Image.asset("assets/images/rebate/nodata.png", width: 200.w, height: 223.w,));
                }
                if ( this.isWithDrawRecord) {
                  UserWithdrawModel userWithdrawModel;
                  userWithdrawModel = controller.userWithdrawState.userWithdrawModels[index];
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
                  UserRechargeModel userRechargeModel;
                  userRechargeModel = controller.userRechargeState.userRechargeModels[index];
                  var viewModel = RechargeRecordListChildViewModel(
                    orderN: userRechargeModel.sn,
                    createTime: userRechargeModel.createTime,
                    payName: userRechargeModel.payName,
                    money: userRechargeModel.money,
                    status_name:  userRechargeModel.statusName,
                  );
                  return  RechargeRecordListChild(viewModel);
                }
          },
          childCount: userWithdrawModels.isEmpty ? 1 : userWithdrawModels.length
      ),
    );
  }
}

