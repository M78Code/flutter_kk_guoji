import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';
import '../../routes/routes.dart';
import '../../utils/route_util.dart';
import '../home/view/home_top_widget.dart';
import './widgets/index.dart';

class KKGamesPage extends StatefulWidget {
  const KKGamesPage({Key? key}) : super(key: key);

  @override
  State<KKGamesPage> createState() => _KKGamesPageState();
}

class _KKGamesPageState extends State<KKGamesPage> with AutomaticKeepAliveClientMixin {
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
    if (UserService.to.isLogin) {
      UserService.to.fetchUserMoney();
    }
  }
}

class _KKGamesPageGetX extends GetView<GamesLogic> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildView(),
      ),
    );
  }

  Widget _buildView() {
    return Container(
      color: const Color(0xFF171A26),
      child: Column(
        children: [
          KKGamesTopWidget(UserService.to.isLogin),
          SizedBox(  height: 20.w),
          KKGamesMenuWidget(),
          SizedBox(  height: 20.w),
          Expanded(child: GamesItemsWidget())
        ],
      ),
    );
  }

  Widget _buildBalanceWidget() {
    return Container();
  }
}
