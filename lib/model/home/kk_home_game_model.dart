// To parse this JSON data, do
//
//     final jcpRecommendGameModel = jcpRecommendGameModelFromJson(jsonString);

import 'dart:convert';

JcpRecommendGameModel jcpRecommendGameModelFromJson(String str) => JcpRecommendGameModel.fromJson(json.decode(str));

String jcpRecommendGameModelToJson(JcpRecommendGameModel data) => json.encode(data.toJson());

class JcpRecommendGameModel {
  String gameId;
  String gameIcon;
  String gameName;

  JcpRecommendGameModel({
    required this.gameId,
    required this.gameIcon,
    required this.gameName,
  });

  factory JcpRecommendGameModel.fromJson(Map<String, dynamic> json) => JcpRecommendGameModel(
    gameId: json["gameId"],
    gameIcon: json["gameIcon"],
    gameName: json["gameName"],
  );

  Map<String, dynamic> toJson() => {
    "gameId": gameId,
    "gameIcon": gameIcon,
    "gameName": gameName,
  };
}
