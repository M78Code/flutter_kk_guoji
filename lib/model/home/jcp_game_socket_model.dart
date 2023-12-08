// To parse this JSON data, do
//
//     final jcpGameSocketModel = jcpGameSocketModelFromJson(jsonString);

import 'dart:convert';

JcpGameSocketModel jcpGameSocketModelFromJson(String str) => JcpGameSocketModel.fromJson(json.decode(str));

String jcpGameSocketModelToJson(JcpGameSocketModel data) => json.encode(data.toJson());

class JcpGameSocketModel {
  String? autoCloseDate;
  String? autoDrawingDate;
  String? drawingResult;
  String? lotteryCode;
  String? periodsNumber;
  String? status;
  String? isValidity;
  String? sign;

  JcpGameSocketModel({
    this.autoCloseDate,
    this.autoDrawingDate,
    this.drawingResult,
    this.lotteryCode,
    this.periodsNumber,
    this.status,
    this.isValidity,
    this.sign,
  });

  factory JcpGameSocketModel.fromJson(Map<String, dynamic> json) => JcpGameSocketModel(
    autoCloseDate: json["autoCloseDate"],
    autoDrawingDate: json["autoDrawingDate"],
    drawingResult: json["drawingResult"],
    lotteryCode: json["lotteryCode"],
    periodsNumber: json["periodsNumber"],
    status: json["status"],
    isValidity: json["isValidity"],
    sign: json["sign"],
  );

  Map<String, dynamic> toJson() => {
    "autoCloseDate": autoCloseDate,
    "autoDrawingDate": autoDrawingDate,
    "drawingResult": drawingResult,
    "lotteryCode": lotteryCode,
    "periodsNumber": periodsNumber,
    "status": status,
    "isValidity": isValidity,
    "sign": sign,
  };
}
