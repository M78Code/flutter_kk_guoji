import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../common/api/account_api.dart';
import '../../../common/api/games_api.dart';
import '../../../common/models/bet_list_response_model.dart';
import '../../../common/models/game/game_list_response_model.dart';
import '../../../common/models/game_type_list_response_model.dart';
import '../../../services/user_service.dart';
import 'state.dart';
import 'package:intl/intl.dart';

class BetListController extends GetxController {
  final BetListState state = BetListState();

  List<GameTypeModel> gameTypeModels = [GameTypeModel(id: 0,name: '全部类型')];
  List<GameModel> gameModels = [GameModel(id: 0,name: '全部游戏')];
  List<BetModel> betModels = [];
  GameTypeModel selectedGameTypeModel = GameTypeModel(id: 0,name: '全部类型');
  GameModel selectedGameModel = GameModel(id: 0,name: '全部游戏');

  final List<List<String>> dateTypes = [["today","今天"], ["yesterday","昨天" ], ["month","本月"], ["last_month","上月"],];
  String? dateType = "today";
  DateTime? startDate;
  DateTime? endDate;
  int page = 1;
  bool isNoMoreData = false;
  EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  EasyRefreshController get refreshController => _refreshController;
  var gameSearchKey = "";

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
    this.startDate = null;
    this.endDate = null;
    update(['dateSelector']);
    await onRefresh();
  }

  switchDate(DateTime startDate, DateTime endDate) async {
    this.dateType = null;
    this.startDate = startDate;
    this.endDate = endDate;
    update(['dateSelector']);
    await onRefresh();
  }

  onTapSwitchGameTyp(int index) async {
    if (this.selectedGameTypeModel.id == gameTypeModels[index].id) { return; }
    this.selectedGameTypeModel = gameTypeModels[index];
    this.selectedGameModel = GameModel(id: 0,name: '全部游戏');
    update(['gameTypeMenu']);
    update(['menu']);
    fetchGameList();
    await onRefresh();
  }

  onTapSwitchGame(GameModel gameModel) async {
    if (this.selectedGameModel.id == gameModel.id) { return; }
    this.selectedGameModel = gameModel;
    update(['gameMenu']);
    update(['menu']);
    await onRefresh();
  }

  gameSearchKeyChange(String searchKey) {
    this.gameSearchKey = searchKey;
    update(['gameMenu']);
  }

  initData() {
    UserService.to.fetchUserMoney();
    fetchGameTypeList();
    fetchGameList();
    fetchBetList(true);
  }

  fetchGameTypeList() async {
    List<GameTypeModel>? gameTypeModels = await GamesApi.getGameTypeList();
    this.gameTypeModels = (gameTypeModels ?? []);
    this.gameTypeModels.insert(0, GameTypeModel(id: 0,name: '全部类型'));
  }

  fetchGameList() async {
    GameListModel? gameModels = await GamesApi.getGameList(selectedGameTypeModel.id);
    this.gameModels = gameModels?.list ?? [];
    this.gameModels.insert(0, GameModel(id: 0,name: '全部游戏'));
  }
  Future<void> fetchBetList(isRefresh) async {
    if (isRefresh) {
      page = 1;
    }
    else {
      ++page;
    }
    String dateRange;
    if (startDate != null && endDate != null) {
      var startText = DateFormat('yyyy-MM-dd').format(startDate!);
      var endText = DateFormat('yyyy-MM-dd').format(endDate!);
      dateRange = startText + " - " + endText;
    }
    else {
      dateRange = dateType ?? "";
    }

    BetListModel? betListModel = await AccountApi.getBetList(dateRange, page, selectedGameTypeModel.id, selectedGameModel.id);
    if (betListModel != null) {
      if (isRefresh) {
        this.betModels = betListModel.list ?? [];
      }
      else {
        this.betModels.addAll(betListModel.list ?? []);
      }
      this.isNoMoreData = (betListModel.total ?? 0) <= this.betModels.length;
      update(["betListPage"]);
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
