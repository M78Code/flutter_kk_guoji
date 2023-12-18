import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../common/api/account_api.dart';
import '../../../common/api/games_api.dart';
import '../../../common/models/game_type_list_response_model.dart';
import 'state.dart';

class BetListController extends GetxController {
  final BetListState state = BetListState();

  // UserMoneyDetailsModel? userMoneyDetailsModel;
  List<GameTypeModel> gameTypeModels = [];
  final List<List<String>> dateTypes = [["today","今天"], ["yesterday","昨天" ], ["month","本月"], ["last_month","上月"],];
  var dateType = "today";
  int page = 1;
  bool isNoMoreData = false;
  EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  EasyRefreshController get refreshController => _refreshController;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // 日期切换
  onTapSwitchDate(String dateType) async {
    this.dateType = dateType;
    update(['dateSelector']);
    // _refreshController.resetNoData();
    await onRefresh();
  }

  initData() {
    fetchGameTypeList();
    // getUserMoneyDetailsSearch(true);
  }

  fetchGameTypeList() async {

    List<GameTypeModel>? gameTypeModels = await GamesApi.getGameTypeList();
    this.gameTypeModels = gameTypeModels ?? [];
  }
  Future<void> onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // await initData();
    // if failed,use refreshFailed()
    _refreshController.finishRefresh();
    _refreshController.resetFooter();
    if (this.isNoMoreData) {
      _refreshController.finishLoad(IndicatorResult.noMore);
    }
  }

  void onLoading() async{
    // monitor network fetch
    // await getUserMoneyDetailsSearch(false);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.finishRefresh();
    if (this.isNoMoreData) {
      _refreshController.finishLoad(IndicatorResult.noMore);
    }
  }
}
