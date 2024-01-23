import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/games/games_logic.dart';
import 'package:kkguoji/services/user_service.dart';
import './widgets/index.dart';
import 'package:easy_refresh/easy_refresh.dart';

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
  final GamesLogic controller = Get.find<GamesLogic>();
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
      child: EasyRefresh(
        controller: controller.refreshController,
        onRefresh: () async {
          controller.onRefresh();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: KKGamesTopWidget(UserService.to.isLogin),),
            SliverToBoxAdapter(child: SizedBox(height: 20.w)),
            SliverToBoxAdapter(child: KKGamesMenuWidget(),),
            SliverToBoxAdapter(child: SizedBox(height: 20.w)),
            SliverFillRemaining(child: GamesItemsWidget())
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceWidget() {
    return Container();
  }
}
