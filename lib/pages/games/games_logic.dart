
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';
import 'package:kkguoji/common/api/games_api.dart';
import '../../common/models/user_money_model.dart';
import '../../generated/assets.dart';

class GamesLogic extends GetxController {

  var currentIndex  = 0;
  late PageController pageController = PageController(initialPage: 0);
  UserMoneyModel? userMoneyModel;

  final List<List<String>> menuList = [
    [Assets.gamesGamesHot, Assets.gamesGamesHotArrow,"热门","热门游戏"],
    [Assets.gamesGamesLottery, Assets.gamesGamesLotteryArrow, "彩票", "彩票游戏"],
    [Assets.gamesGamesVideo, Assets.gamesGamesVideoArrow, "视讯","真人视讯"],
    [Assets.gamesGamesSports, Assets.gamesGamesSportsArrow, "体育","体育游戏"],
  ];

  final List<List<String>> lotteryList = [
    [Assets.gamesLotteryLiuhe, "香港六合彩"],
    [Assets.gamesLotteryTixincai, "七星彩"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛"],
    [Assets.gamesCanadaShishicai, "加拿大时时彩"],
    [Assets.gamesCanada28, "加拿大2.8"],
    [Assets.gamesCanada50, "加拿大5.0"],
    [Assets.gamesCanada4246, "加拿大4.2-4.6"],
    [Assets.gamesCanadaWanpan, "加拿大网盘赔率"],
    [Assets.gamesBaijialeVideo, "主播百家乐"],
    [Assets.gamesBaijialeQuick, "极速百家乐"],
    [Assets.gamesBaijialeOm, "欧美百家乐"],

  ];

  final List<List<String>> realList = [
    [Assets.gamesRealClassicBaijiale, Assets.gamesGamesHotArrow,"经典百家乐"],
    [Assets.gamesRealQuickBaijale, Assets.gamesGamesLotteryArrow, ""],
    [Assets.gamesRealWheelBaijiale, Assets.gamesGamesVideoArrow, ""],
    [Assets.gamesRealOmBaijiale, Assets.gamesGamesSportsArrow, ""],
  ];

  menuOntap(int index) {
    currentIndex = index;
    update(["menu"]);
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  switchIndex(int index) {
    currentIndex = index;
    update(["menu"]);
  }
  initUserMoney() async {
    // var result = GamesApi.games();
    UserMoneyModel? userMoney = await AccountApi.getUserMoney();
    if (userMoney != null) {
      userMoneyModel = userMoney;
    }
  }
  initGames() async {
    // var result = GamesApi.games();
    // UserMoneyModel? userMoney = await GamesApi.games();
    // if (userMoney != null) {
    //   userMoneyModel = userMoney;
    // }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

}