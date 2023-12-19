import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../common/api/account_api.dart';
import '../../../common/api/games_api.dart';
import '../../../common/models/bet_list_response_model.dart';
import '../../../common/models/game/game_list_response_model.dart';
import '../../../common/models/game_type_list_response_model.dart';
import 'state.dart';

class BetListController extends GetxController {
  final BetListState state = BetListState();

  // UserMoneyDetailsModel? userMoneyDetailsModel;
  List<GameTypeModel> gameTypeModels = [];
  List<GameModel> gameModels = [];
  List<BetModel> betModels = [];
  GameTypeModel? selectedGameTypeModel;
  GameModel? selectedGameModel;
  
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
    await onRefresh();
  }

  onTapSwitchGameTyp(int index) async {
    if (this.selectedGameTypeModel == gameTypeModels[index]) { return; }
    this.selectedGameTypeModel = gameTypeModels[index];
    this.selectedGameModel = null;
    update(['gameTypeMenu']);
    fetchGameList();
    await onRefresh();
  }

  onTapSwitchGame(int index) async {
    if (this.selectedGameModel == gameModels[index]) { return; }
    this.selectedGameModel = gameModels[index];
    update(['gameMenu']);
    // _refreshController.resetNoData();
    await onRefresh();
  }

  initData() {
    fetchGameTypeList();
    fetchGameList();
    fetchBetList(true);
  }

  fetchGameTypeList() async {
    List<GameTypeModel>? gameTypeModels = await GamesApi.getGameTypeList();
    this.gameTypeModels = gameTypeModels ?? [];
  }

  fetchGameList() async {
    GameListModel? gameModels = await GamesApi.getGameList(selectedGameTypeModel?.id);
    this.gameModels = gameModels?.list ?? [];
  }
  Future<void> fetchBetList(isRefresh) async {
    if (isRefresh) {
      page = 1;
    }
    else {
      ++page;
    }
    BetListModel? betListModel = await AccountApi.getBetList(dateType, page, selectedGameTypeModel?.id, selectedGameModel?.id);
    if (betListModel != null) {
      if (isRefresh) {
        this.betModels = betListModel.list ?? [];
      }
      else {
        this.betModels.addAll(betListModel.list ?? []);
      }
      this.isNoMoreData = (betListModel.total ?? 0) <= this.betModels.length;
      update(["betList"]);
      print(betListModel);
    }
    return;
  }

  Future<void> onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await fetchBetList(true);
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
