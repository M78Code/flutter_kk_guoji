// To parse this JSON data, do
//
//     final jcpBetModel = jcpBetModelFromJson(jsonString);

import 'dart:convert';

JcpBetModel jcpBetModelFromJson(String str) => JcpBetModel.fromJson(json.decode(str));

String jcpBetModelToJson(JcpBetModel data) => json.encode(data.toJson());

class JcpBetModel {
  String lotteryCode;
  String playTypeCode;
  String sonPlayTypeCode;
  String playCode;
  String betContent;
  String betAmount;

  JcpBetModel({
    required this.lotteryCode,
    required this.playTypeCode,
    required this.sonPlayTypeCode,
    required this.playCode,
    required this.betContent,
    required this.betAmount,
  });

  factory JcpBetModel.fromJson(Map<String, dynamic> json) => JcpBetModel(
    lotteryCode: json["lotteryCode"],
    playTypeCode: json["playTypeCode"],
    sonPlayTypeCode: json["sonPlayTypeCode"],
    playCode: json["playCode"],
    betContent: json["betContent"],
    betAmount: json["betAmount"],
  );

  Map<String, dynamic> toJson() => {
    "lotteryCode": lotteryCode,
    "playTypeCode": playTypeCode,
    "sonPlayTypeCode": sonPlayTypeCode,
    "playCode": playCode,
    "betContent": betContent,
    "betAmount": betAmount,
  };
}
