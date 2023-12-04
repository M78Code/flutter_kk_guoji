
import 'package:get/get.dart';

import '../../generated/assets.dart';

class GamesLogic extends GetxController {

  var currentIndex  = 0.obs;

  late List<List<String>> dataList;

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
    [Assets.gamesLotteryLiuhe, "香港六合彩"],
    [Assets.gamesLotteryTixincai, "七星彩"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛"],
    [Assets.gamesLotteryLiuhe, "香港六合彩"],
    [Assets.gamesLotteryTixincai, "七星彩"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛"],
    [Assets.gamesLotteryLiuhe, "香港六合彩"],
    [Assets.gamesLotteryTixincai, "七星彩"],
    [Assets.gamesLotteryPcBaijiale, "PC百家乐"],
    [Assets.gamesLotteryPcNuinui, "PC牛牛"],
  ];

  final List<List<String>> realList = [
    [Assets.gamesRealClassicBaijiale, Assets.gamesGamesHotArrow,"经典百家乐"],
    [Assets.gamesRealQuickBaijale, Assets.gamesGamesLotteryArrow, ""],
    [Assets.gamesRealWheelBaijiale, Assets.gamesGamesVideoArrow, ""],
    [Assets.gamesRealOmBaijiale, Assets.gamesGamesSportsArrow, ""],
  ];

  switchIndex(int index) {
    currentIndex.value = index;
    dataList = index == 0 ? lotteryList : realList;
    // update(["games"]);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dataList = lotteryList;
  }
}