import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/mine/wallet/index/widgets/mine_wallet_balance_widget.dart';

import '../../../../generated/assets.dart';
import '../../../../routes/routes.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/route_util.dart';
import 'logic.dart';


class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with AutomaticKeepAliveClientMixin {

  // final GamesLogic controller = Get.find<GamesLogic>();

  @override
  bool get wantKeepAlive => true;
  final _WalletPageGetx pageGetx = _WalletPageGetx();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return pageGetx;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserService.to.fetchUserMoney();
  }
}

class _WalletPageGetx extends StatelessWidget {
  _WalletPageGetx({Key? key}) : super(key: key);

  final logic = Get.put(WalletLogic());
  final state = Get.find<WalletLogic>().state;

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的钱包'),
        leading:  IconButton(
          icon: Image.asset(
              Assets.systemIconBack,
              width: 20.w,
              height: 20.w),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.w,),
            MineWalletBalanceWidget().marginSymmetric(horizontal: 12.w),
            SizedBox(height: 20.w,),
            _buildActionView('资金明细',Assets.mineWalletFundDetails, (){
              RouteUtil.pushToView(Routes.walletFundDetailPage);
            }),
            Divider(height: 1,color: Color(0x66FFFFFF),).opacity(0.3).marginSymmetric(horizontal: 12.w),
            _buildActionView('交易记录',Assets.mineWalletTransactionRecords, (){
              RouteUtil.pushToView(Routes.walletRecordPage);
            }),
            Spacer(),
          ]
        ),
      ),
    );
  }

  Widget _buildActionView(String title,String image, Function onTap) {
    return Container(
      height: 32.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                width: 16.w,
                height: 16.w,
              ),
              const SizedBox(  width: 5),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Image.asset(
            Assets.mineWalletArrow,
            width: 16.w,
            height: 16.w,
          )
        ],
      ),
    ).onTap(() {
      onTap.call();
    });
  }

}
