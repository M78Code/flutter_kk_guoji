
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';
import 'package:kkguoji/common/api/games_api.dart';
import '../../common/models/game/game_list_response_model.dart' as gameList;
import '../../common/models/game_login.dart';
import '../../common/models/get_game_model.dart';
import '../../common/models/group_game_list_model.dart';
import '../../common/models/user_money_model.dart';
import '../../generated/assets.dart';
import '../../routes/routes.dart';
import '../../utils/route_util.dart';

class GamesLogic extends GetxController {

  var currentIndex  = 0;
  late PageController pageController = PageController(initialPage: 0);
  List<GroupGameData> groupGameDatas = [];
  List<GameModel> lottryGameModels = [];
  EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  EasyRefreshController get refreshController => _refreshController;

  final  List<List<String>> menuList = [
    [Assets.gamesGamesHot, Assets.gamesGamesHotArrow,"热门","热门游戏", "-1"],
    [Assets.gamesGamesLottery, Assets.gamesGamesLotteryArrow, "彩票", "彩票游戏", "3"],
    [Assets.gamesGamesVideo, Assets.gamesGamesVideoArrow, "视讯","真人视讯", "1"],
    [Assets.gamesGamesSports, Assets.gamesGamesSportsArrow, "体育","体育游戏", "4"],
  ];

  menuOntap(int index) {
    pageController.jumpToPage(
      index
    );
  }

  switchIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    update(["menu"]);
  }

  _initGames() async {
    GroupGameListModel? groupGameListModel = await GamesApi.games();
    await fetchLottryGameList();
    if (groupGameListModel?.data != null) {
      groupGameDatas = groupGameListModel!.data!;
      update(["menu"]);
      update(["games"]);
    }
  }

  // 彩票游戏
  fetchLottryGameList() async {
    gameList.GameListModel? gameModels = await GamesApi.getGameList(3);
    var lottryGameList = gameModels?.list ?? [];
    this.lottryGameModels = lottryGameList.map((e) {
      return GameModel(image: e.image, name: e.name, id: e.id, gameCompanyCode: e.gameCompanyCode);
    }).toList();
  }

  gamesOnTapFormApi(GameModel gameModel) async {
    GameLogin? gameLogin = await GamesApi.gameLogin(gameModel.gameCompanyCode ?? "", (gameModel.id ?? "").toString());
    if (gameLogin?.url != null) {
      RouteUtil.pushToView(Routes.webView, arguments: gameLogin?.url ?? "");
    }
  }

  Future<void> onRefresh() async{
    await  _initGames();
    refreshController.finishRefresh();
    refreshController.resetFooter();
    refreshController.finishLoad();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _initGames();
  }

}