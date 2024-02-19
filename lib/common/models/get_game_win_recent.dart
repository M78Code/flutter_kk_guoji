// To parse this JSON data, do
//
//     final getGameWinRecent = getGameWinRecentFromJson(jsonString);

import 'dart:convert';

GetGameWinRecent getGameWinRecentFromJson(String str) => GetGameWinRecent.fromJson(json.decode(str));

String getGameWinRecentToJson(GetGameWinRecent data) => json.encode(data.toJson());

class GetGameWinRecent {
  String event;
  List<WinGame> data;

  GetGameWinRecent({
    required this.event,
    required this.data,
  });

  factory GetGameWinRecent.fromJson(Map<String, dynamic> json) => GetGameWinRecent(
    event: json["event"],
    data: List<WinGame>.from(json["data"].map((x) => WinGame.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WinGame {
  String gameBet;
  String gameProfit;
  int gameRealId;
  String gameCurrency;
  int gameWinStatus;
  String gameExchangeBet;
  String gameExchangeWin;
  String gameExchangeProfit;
  String userNick;
  String gameName;
  String image;
  String gameUnit;

  WinGame({
    required this.gameBet,
    required this.gameProfit,
    required this.gameRealId,
    required this.gameCurrency,
    required this.gameWinStatus,
    required this.gameExchangeBet,
    required this.gameExchangeWin,
    required this.gameExchangeProfit,
    required this.userNick,
    required this.gameName,
    required this.image,
    required this.gameUnit,
  });

  factory WinGame.fromJson(Map<String, dynamic> json) => WinGame(
    gameBet: json["game_bet"],
    gameProfit: json["game_profit"],
    gameRealId: json["game_real_id"],
    gameCurrency: json["game_currency"],
    gameWinStatus: json["game_win_status"],
    gameExchangeBet: json["game_exchange_bet"],
    gameExchangeWin: json["game_exchange_win"],
    gameExchangeProfit: json["game_exchange_profit"],
    userNick: json["user_nick"],
    gameName: json["game_name"],
    image: json["image"],
    gameUnit: json["game_unit"],
  );

  Map<String, dynamic> toJson() => {
    "game_bet": gameBet,
    "game_profit": gameProfit,
    "game_real_id": gameRealId,
    "game_currency": gameCurrency,
    "game_win_status": gameWinStatus,
    "game_exchange_bet": gameExchangeBet,
    "game_exchange_win": gameExchangeWin,
    "game_exchange_profit": gameExchangeProfit,
    "user_nick": userNick,
    "game_name": gameName,
    "image": image,
    "game_unit": gameUnit,
  };
}
