import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';
import './widgets/index.dart';

class KKGamesPage extends StatefulWidget {
  const KKGamesPage({Key? key}) : super(key: key);

  @override
  State<KKGamesPage> createState() => _KKGamesPageState();
}

class _KKGamesPageState extends State<KKGamesPage>
    with AutomaticKeepAliveClientMixin {

  final GamesLogic controller = Get.find<GamesLogic>();

  @override
  bool get wantKeepAlive => true;
  final _KKGamesPageGetX pageGetx = _KKGamesPageGetX();

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

class _KKGamesPageGetX extends GetView<GamesLogic> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            _buildView(),
            Positioned(
              bottom: 16.w,
              right: 20.w,
              child:Container(
                width: 46.w,
                height: 46.w,
                child: Image.asset(Assets.gamesSupport)
                    .onTap(() {

                })
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildView() {
    return Container(
      color: const Color(0xFF171A26),
      child: Column(
        children: [
          KKGamesTopWidget(),
          Divider(color: Color(0xFFFFFFFF).withOpacity(0.06),height: 1),
          KKGamesMenuWidget(),
          SizedBox(height: 10.w,),
          Expanded(
            child: GamesItemsWidget(),
          )
        ],
      ),
    );
  }

  Widget _buildBalanceWidget() {
    return Container(

    );
  }
}
