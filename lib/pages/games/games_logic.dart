
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';
import 'package:kkguoji/common/api/games_api.dart';
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
  List<GroupGameData> gameModels = [];

  final  List<List<String>> menuList = [
    [Assets.gamesGamesHot, Assets.gamesGamesHotArrow,"热门","热门游戏"],
    [Assets.gamesGamesLottery, Assets.gamesGamesLotteryArrow, "彩票", "彩票游戏"],
    [Assets.gamesGamesVideo, Assets.gamesGamesVideoArrow, "视讯","真人视讯"],
    [Assets.gamesGamesSports, Assets.gamesGamesSportsArrow, "体育","体育游戏"],
  ];


  final List<List<String>> hotList = [
    [Assets.gamesLotteryLiuhe, "香港六合彩", "JCP","XGLHC"],
    [Assets.gamesLotteryTixincai, "七星彩", "JCP","QXC"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐", "JCP", "PCBJL"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛", "JCP", "PCNN"],
    [Assets.gamesCanadaShishicai, "加拿大时时彩", "JCP", "JNDSSC"],
    [Assets.gamesCanada28, "加拿大2.8", "JCP", "JNDEB"],
    [Assets.gamesCanada50, "加拿大5.0", "JCP", "XGLHC"],
    [Assets.gamesCanada4246, "加拿大4.2-4.6", "JCP", "JNDSI"],
    [Assets.gamesCanadaWanpan, "加拿大网盘赔率", "JCP", "JNDWP"],
    [Assets.gamesBaijialeVideo, "主播百家乐", "COG", ""],
    [Assets.gamesBaijialeQuick, "极速百家乐", "COG", ""],
    [Assets.gamesBaijialeOm, "欧美百家乐", "COG", ""],
  ];
  final List<List<String>> lotteryList = [
    [Assets.gamesLotteryLiuhe, "香港六合彩", "JCP","XGLHC"],
    [Assets.gamesLotteryTixincai, "七星彩", "JCP","QXC"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐", "JCP", "PCBJL"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛", "JCP", "PCNN"],
    [Assets.gamesCanadaShishicai, "加拿大时时彩", "JCP", "JNDSSC"],
    [Assets.gamesCanada28, "加拿大2.8", "JCP", "JNDEB"],
    [Assets.gamesCanada50, "加拿大5.0", "JCP", "XGLHC"],
    [Assets.gamesCanada4246, "加拿大4.2-4.6", "JCP", "JNDSI"],
    [Assets.gamesCanadaWanpan, "加拿大网盘赔率", "JCP", "JNDWP"]
  ];

  final List<List<String>> realList = [
    [Assets.gamesRealClassicBaijiale,"经典百家乐", "COG", ""],
    [Assets.gamesRealQuickBaijale, "", "COG", ""],
    [Assets.gamesRealWheelBaijiale, "", "COG", ""],
    [Assets.gamesRealOmBaijiale, "", "COG", ""],
  ];
  final List<List<String>> sportList = [
    [Assets.gamesSport1,"", "FbSports", ""],
    [Assets.gamesSport2, "", "FbSports", ""],
    [Assets.gamesSport3, "", "FbSports", ""],
    [Assets.gamesSport4, "", "FbSports", ""],
  ];


  menuOntap(int index) {
    // currentIndex = index;
    // update(["menu"]);
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
    if (groupGameListModel?.data != null) {
      gameModels = groupGameListModel!.data!;
      update(["menu"]);
      update(["games"]);
    }
  }

  gamesOnTapFormApi(GameModel gameModel) async {
    GameLogin? gameLogin = await GamesApi.gameLogin(gameModel.gameCompanyCode ?? "", (gameModel.id ?? "").toString());
    if (gameLogin?.url != null) {
      RouteUtil.pushToView(Routes.webView, arguments: gameLogin?.url ?? "");
    }
  }

  gamesOnTap(List<String> gameModel) async {

    GetGameModel? getGameModel = await GamesApi.getGameByCompanyCode(gameModel[2], gameModel[3]);
    GameLogin? gameLogin = await GamesApi.gameLogin(getGameModel?.gameCompanyCode ?? "", (getGameModel?.id ?? "").toString());
    if (gameLogin?.url != null) {
      RouteUtil.pushToView(Routes.webView, arguments: gameLogin?.url ?? "");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _initGames();
  }

}