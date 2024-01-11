import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/model/home/jcp_game_socket_model.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/utils/json_util.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/services/http_service.dart';
import 'dart:core';

import 'package:kkguoji/utils/websocket_util.dart';

import '../../../common/api/games_api.dart';
import '../../../common/models/game_login.dart';
import '../../../common/models/get_game_model.dart';
import '../../../model/home/jcp_game_model.dart';
import '../../../model/home/kk_home_game_model.dart';
import '../../../model/home/recommend_game_model.dart';
import '../../../services/http_service.dart';
import '../../../services/user_service.dart';

class HomeLogic extends GetxController {
  final RxString marqueeStr = "".obs;
  final RxList bannerList = [].obs;
  final RxList ticketList = [].obs;
  var gameList = <Datum>[].obs;
  var recommendGameListNew = <RecommendList>[].obs;
  var recommendSportList = <RecommendList>[].obs;
  var margeGameList=<List<Datum>>[].obs;
  final globalController = Get.find<UserService>();
  Map imageMap = {
    "XGLHC": {
      "bg_icon": "assets/images/home_xianggangliuhecai.png",
      "logo_icon": "assets/images/home_liuhecai_icon.png",
      'ball_color': [const Color(0xFFFF5D3A), const Color(0xFFB70000), const Color(0xFFB70000)]
    },
    "PCNN": {
      "bg_icon": "assets/images/home_pcniuniu.png",
      "logo_icon": "assets/images/home_pcniuniu_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFF06873A), const Color(0xFF06873A)]
    },
    "PCBJL": {
      "bg_icon": "assets/images/home_pcbaijiale.png",
      "logo_icon": "assets/images/home_pcbaijiale_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFF1A8BD7), const Color(0xFF1A8BD7)]
    },
    "JNDSI": {
      "bg_icon": "assets/images/home_jianada42.png",
      "logo_icon": "assets/images/home_jianada42_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFFA21111), const Color(0xFFE32D2D)]
    },
    "JNDWU": {
      "bg_icon": "assets/images/home_jianada5.png",
      "logo_icon": "assets/images/home_jianada50_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFFA21111), const Color(0xFFE32D2D)]
    },
    "JNDWP": {
      "bg_icon": "assets/images/home_jianadawangpan.png",
      "logo_icon": "assets/images/home_jianadawangpan_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFF831AD7), const Color(0xFFA32FFF)]
    },
    "JNDEB": {
      "bg_icon": "assets/images/home_jianada28.png",
      "logo_icon": "assets/images/home_jianada28_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFFA21111), const Color(0xFFE32D2D)]
    },
    "JNDSSC": {
      "bg_icon": "assets/images/home_jianadashishicai.png",
      "logo_icon": "assets/images/home_jianadashishicai_icon.png",
      'ball_color': [const Color(0xFFF0F8FF), const Color(0xFFA21111), const Color(0xFFE32D2D)]
    },
    "JNDLHC": {
      "bg_icon": "assets/images/home_xianggangliuhecai.png",
      "logo_icon": "assets/images/home_liuhecai_icon.png",
      'ball_color': [const Color(0xFFFF5D3A), const Color(0xFFB70000), const Color(0xFFB70000)]
    },
  };
  Map statesMap = {"0": "未开奖", "2": "已开奖", "4": "封盘中", "9": "未开盘"};
  final RxMap ticketInfo = {}.obs;
  final RxMap noticeInfo = {}.obs;
  final RxMap haveTimeMap = {}.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    getRecommendGameList();
    getRecommendSportList();

    var result = await HttpRequest.request(HttpConfig.getMarqueeNotice, method: "get");
    if (result["code"] == 200) {
      List marquees = result["data"];
      if (marquees.isNotEmpty) {
        Map m = marquees.first;
        marqueeStr.value = m["content"];
      }
    }

    var gameResult =
        await HttpRequest.request(HttpConfig.getJCPGameList, method: "post");
    if (gameResult["code"] == 200) {
      print('xiaoan 首页彩票列表 ${JsonUtil.encodeObj(gameResult['data'])}');
      JcpGameModel gameModel = JcpGameModel.fromJson(gameResult);
      List<Datum> gameData = gameModel.data ?? [];
      if (gameData.isNotEmpty) {
        List<Datum> newData = gameData.where((element) {
          String lotteryCode = element.lotteryCode ?? '';
          return lotteryCode != "HXEB" &&
              lotteryCode != "QXC" &&
              lotteryCode != "JNDLHC" &&
              lotteryCode != "PLS";
        }).toList();
        gameList.clear();
        gameList.addAll(newData);
        margeData();
      }
    }

    Map<String, dynamic> bannerParms = {"position": "home_banner"};
    var bannerResult = await HttpRequest.request(HttpConfig.getBannerList,
        params: bannerParms, method: "get");
    if (bannerResult["code"] == 200) {
      bannerList.value = bannerResult["data"];
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    WebSocketUtil().listenTicketMessage((msg) {
      ticketInfo.value = msg;
      updateTicketInfo();
    });
    WebSocketUtil().listenNoticeMessage((msg) {
      noticeInfo.value=msg;
      print('xiaoan 首页跑马灯Socket ${JsonUtil.encodeObj(noticeInfo)}');
    });
  }

  updateMoney(){
    globalController.fetchUserMoney();
  }

  getRecommendGameList() async {
    Map<String, dynamic> params = {"is_hot": "1",'is_mobile':'1','limit':'6'};
    var gameResult = await HttpRequest.request(HttpConfig.getGameList,
        params: params, method: "post");
    print('xiaoan 首页推荐列表 ${JsonUtil.encodeObj(gameResult)}');
    if (gameResult["code"] == 200) {
      RecommendGameModel recommendGameModel=RecommendGameModel.fromJson(gameResult);
      if(recommendGameModel.data.list!=null){
        ///数据重新排序
        List<RecommendList> newList=sortDataList(recommendGameModel.data.list,3);
        recommendGameListNew.clear();
        recommendGameListNew.addAll(newList);
      }
    }
  }

  getRecommendSportList() async {
    Map<String, dynamic> params = {"type": "4",'is_mobile':'1','limit':'4'};
    var gameResult = await HttpRequest.request(HttpConfig.getGameList,
        params: params, method: "post");
    if (gameResult["code"] == 200) {
      RecommendGameModel recommendGameModel=RecommendGameModel.fromJson(gameResult);
      if(recommendGameModel.data.list!=null){
        ///数据重新排序
        recommendSportList.clear();
        recommendSportList.addAll(recommendGameModel.data.list);
        print('xiaoan 首页体育列表 ${JsonUtil.encodeObj(gameResult)}');
      }
    }
  }

  // 将数据列表按照纵向滚动指定列数的顺序进行排序
  List<RecommendList> sortDataList(List<RecommendList> dataList, int columns) {
    List<RecommendList> sortedList = [];
    for (int i = 0; i < dataList.length; i++) {
      sortedList.add(dataList[i]);
      int nextIndex = i + columns;
      if (nextIndex < dataList.length) {
        sortedList.add(dataList[nextIndex]);
      }
    }
    return sortedList;
  }

  updateTicketInfo() {
    print('xiaoan 首页彩票列表Socket ${JsonUtil.encodeObj(ticketInfo)}');
    ticketInfo.forEach((key, value) {
      JcpGameSocketModel socketModel=JcpGameSocketModel.fromJson(value);
      Datum? item =
          gameList.firstWhereOrNull((p0) => (p0.lotteryCode??'') == key);
      if (item != null) {
        item.current?.isOpen=true;
        Future.delayed(const Duration(seconds: 5), () {
          item.isValidity=int.parse(socketModel.isValidity ?? '1');
          item.last?.periodsNumber++;
          item.last?.drawingResult=socketModel.drawingResult;

          item.current?.periodsNumber++;
          item.current?.autoCloseDate=num.parse(socketModel.autoCloseDate ?? '0');
          item.current?.autoDrawingDate=num.parse(socketModel.autoDrawingDate ?? '0');
          item.current?.isOpen=false;
        });
      }
    });
    gameList.refresh();
  }

  List constructList(int len, List list) {
    var length = list.length; //列表数组数据总条数
    List result = []; //结果集合
    int index = 1;
    //循环 构造固定长度列表数组
    while (true) {
      if (index * len < length) {
        List temp = list.skip((index - 1) * len).take(len).toList();
        result.add(temp);
        index++;
        continue;
      }
      List temp = list.skip((index - 1) * len).toList();
      result.add(temp);
      break;
    }
    return result;
  }

  void openGame() async{
     Map<String, dynamic> map= {"company_code":"COG"};
     var result = await HttpRequest.request(HttpConfig.getGameByCompanyCode, params: map);
     if(result["code"] == 200) {
       loginGame(result["data"]);
       // gameLoginCallBack();
     }
  }

  void openTickGame() async {
    Map<String, dynamic> map= {"company_code":"JCP"};
    var result = await HttpRequest.request(HttpConfig.getGameByCompanyCode, params: map);
    if(result["code"] == 200) {
      loginGame(result["data"]);
    }
}

  void openSportGame() async{
    Map<String, dynamic> map= {"company_code":"FbSports"};
    var result = await HttpRequest.request(HttpConfig.getGameByCompanyCode, params: map);
    if(result["code"] == 200) {
      loginGame(result["data"]);
      // gameLoginCallBack();
    }
  }

  // void gameLoginCallBack() async {
  //   var result = await HttpRequest.request(HttpConfig.gameLoginCallback, method: "post");
  //   if(result["code"] == 200) {
  //     loginGame(result["data"]);
  //   }
  // }

  void loginGame(Map gameMap) async {
    Map gameInfo = gameMap.values.first;
    Map<String, dynamic> params = {"game_id":gameInfo["id"] };
    var result = await HttpRequest.request(HttpConfig.loginGame, method: "post", params: params);
    if(result["code"] == 200) {
      RouteUtil.pushToView(Routes.webView, arguments: result["data"]["url"]);
    }
  }

  gamesOnTap(String type,String lotteryId) async {
    GetGameModel? getGameModel = await GamesApi.getGameByCompanyCode(type, lotteryId);
    GameLogin? gameLogin = await GamesApi.gameLogin(getGameModel?.gameCompanyCode ?? "", (getGameModel?.id ?? "").toString());
    if (gameLogin?.url != null) {
      RouteUtil.pushToView(Routes.webView, arguments: gameLogin?.url ?? "");
    }
  }

  margeData() {
    margeGameList.clear();
    for (int i = 0; i < gameList.length; i += 2) {
      // 切片获取每两个对象
      List<Datum> pair = gameList.sublist(i, i + 2);
      // 添加到结果集合
      margeGameList.add(pair);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }



}
