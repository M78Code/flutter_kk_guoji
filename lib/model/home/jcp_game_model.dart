// To parse this JSON data, do
//
//     final jcpGameModel = jcpGameModelFromJson(jsonString);

import 'dart:convert';

JcpGameModel jcpGameModelFromJson(String str) => JcpGameModel.fromJson(json.decode(str));

String jcpGameModelToJson(JcpGameModel data) => json.encode(data.toJson());

class JcpGameModel {
  bool? success;
  String? message;
  int? code;
  List<Datum>? data;

  JcpGameModel({
    this.success,
    this.message,
    this.code,
    this.data,
  });

  factory JcpGameModel.fromJson(Map<String, dynamic> json) => JcpGameModel(
    success: json["success"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? lotteryCode;
  String? lotteryName;
  int? orderNum;
  String? iconUrl;
  String? moveIconUrl;
  int? isValidity;
  String? remark;
  int? maxReward;
  int? defaultAmount;
  bool? cancelOrder;
  Current? current;
  Last? last;
  Play? play;

  Datum({
    this.lotteryCode,
    this.lotteryName,
    this.orderNum,
    this.iconUrl,
    this.moveIconUrl,
    this.isValidity,
    this.remark,
    this.maxReward,
    this.cancelOrder,
    this.current,
    this.last,
    this.play,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    lotteryCode: json["lotteryCode"],
    lotteryName: json["lotteryName"],
    orderNum: json["orderNum"],
    iconUrl: json["iconUrl"],
    moveIconUrl: json["moveIconUrl"],
    isValidity: json["isValidity"],
    remark: json["remark"],
    maxReward: json["maxReward"],
    cancelOrder: json["cancelOrder"],
    current: json["current"] == null ? null : Current.fromJson(json["current"]),
    last: json["last"] == null ? null : Last.fromJson(json["last"]),
    play: json["play"] == null ? null : Play.fromJson(json["play"]),
  );

  Map<String, dynamic> toJson() => {
    "lotteryCode": lotteryCode,
    "lotteryName": lotteryName,
    "orderNum": orderNum,
    "iconUrl": iconUrl,
    "moveIconUrl": moveIconUrl,
    "isValidity": isValidity,
    "remark": remark,
    "maxReward": maxReward,
    "cancelOrder": cancelOrder,
    "current": current?.toJson(),
    "last": last?.toJson(),
    "play": play?.toJson(),
  };
}

class Current {
  String? lotteryCode;
  String? lotteryName;
  num periodsNumber;
  num? autoCloseDate;
  num? autoDrawingDate;
  int? status;

  Current({
    this.lotteryCode,
    this.lotteryName,
    required this.periodsNumber,
    this.autoCloseDate,
    this.autoDrawingDate,
    this.status,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lotteryCode: json["lotteryCode"],
    lotteryName: json["lotteryName"],
    periodsNumber: json["periodsNumber"],
    autoCloseDate: json["autoCloseDate"],
    autoDrawingDate: json["autoDrawingDate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "lotteryCode": lotteryCode,
    "lotteryName": lotteryName,
    "periodsNumber": periodsNumber,
    "autoCloseDate": autoCloseDate,
    "autoDrawingDate": autoDrawingDate,
    "status": status,
  };
}

class Last {
  String? lotteryName;
  int periodsNumber;
  String? drawingResult;
  String? drawingUrl;
  String? drawingHash;
  int? status;

  Last({
    this.lotteryName,
    required this.periodsNumber,
    this.drawingResult,
    this.drawingUrl,
    this.drawingHash,
    this.status,
  });

  factory Last.fromJson(Map<String, dynamic> json) => Last(
    lotteryName: json["lotteryName"],
    periodsNumber: json["periodsNumber"],
    drawingResult: json["drawingResult"],
    drawingUrl: json["drawingUrl"],
    drawingHash: json["drawingHash"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "lotteryName": lotteryName,
    "periodsNumber": periodsNumber,
    "drawingResult": drawingResult,
    "drawingUrl": drawingUrl,
    "drawingHash": drawingHash,
    "status": status,
  };
}

class Play {
  String? playTypeName;
  String? playTypeCode;
  String? lotteryCode;
  int? orderNum;
  bool? isSelect=false;
  List<Play>? lotteryPlayTypeList;
  List<CachePlayList>? cachePlayList;

  Play({
    this.playTypeName,
    this.playTypeCode,
    this.lotteryCode,
    this.orderNum,
    this.lotteryPlayTypeList,
    this.cachePlayList,
    this.isSelect,
  });

  factory Play.fromJson(Map<String, dynamic> json) => Play(
    playTypeName: json["playTypeName"],
    playTypeCode: json["playTypeCode"],
    lotteryCode: json["lotteryCode"],
    orderNum: json["orderNum"],
    lotteryPlayTypeList: json["lotteryPlayTypeList"] == null ? [] : List<Play>.from(json["lotteryPlayTypeList"]!.map((x) => Play.fromJson(x))),
    cachePlayList: json["cachePlayList"] == null ? [] : List<CachePlayList>.from(json["cachePlayList"]!.map((x) => CachePlayList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "playTypeName": playTypeName,
    "playTypeCode": playTypeCode,
    "lotteryCode": lotteryCode,
    "orderNum": orderNum,
    "lotteryPlayTypeList": lotteryPlayTypeList == null ? [] : List<dynamic>.from(lotteryPlayTypeList!.map((x) => x.toJson())),
    "cachePlayList": cachePlayList == null ? [] : List<dynamic>.from(cachePlayList!.map((x) => x.toJson())),
  };
}

class CachePlayList {
  String? playName;
  String? playCode;
  String? playTypeCode;
  String? sonPlayTypeCode;
  double? odds;
  double? maxOdds;
  double? returnPointRatio;
  int? singleMaxLimit;
  int? singleMinLimit;
  List<ListElement>? list;
  bool? isSelect;

  CachePlayList({
    this.playName,
    this.playCode,
    this.playTypeCode,
    this.sonPlayTypeCode,
    this.odds,
    this.maxOdds,
    this.returnPointRatio,
    this.singleMaxLimit,
    this.singleMinLimit,
    this.list,
    this.isSelect,
  });

  factory CachePlayList.fromJson(Map<String, dynamic> json) => CachePlayList(
    playName: json["playName"],
    playCode: json["playCode"],
    playTypeCode: json["playTypeCode"],
    sonPlayTypeCode: json["sonPlayTypeCode"],
    odds: json["odds"]?.toDouble(),
    maxOdds: json["maxOdds"]?.toDouble(),
    returnPointRatio: json["returnPointRatio"]?.toDouble(),
    singleMaxLimit: json["singleMaxLimit"],
    singleMinLimit: json["singleMinLimit"],
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "playName": playName,
    "playCode": playCode,
    "playTypeCode": playTypeCodeValues.reverse[playTypeCode],
    "sonPlayTypeCode": sonPlayTypeCode,
    "odds": odds,
    "maxOdds": maxOdds,
    "returnPointRatio": returnPointRatio,
    "singleMaxLimit": singleMaxLimit,
    "singleMinLimit": singleMinLimit,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  String? awardsCode;
  String? awardsName;
  num? odds;
  num? maxOdds;
  num? orderNum;

  ListElement({
    this.awardsCode,
    this.awardsName,
    this.odds,
    this.maxOdds,
    this.orderNum,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    awardsCode: json["awardsCode"],
    awardsName: json["awardsName"],
    odds: json["odds"],
    maxOdds: json["maxOdds"],
    orderNum: json["orderNum"],
  );

  Map<String, dynamic> toJson() => {
    "awardsCode": awardsCode,
    "awardsName": awardsName,
    "odds": odds,
    "maxOdds": maxOdds,
    "orderNum": orderNum,
  };
}

enum PlayTypeCode {
  QXCEM,
  TMSB,
  TMZH,
  XAB,
  ZHDXDS,
  ZXH
}

final playTypeCodeValues = EnumValues({
  "QXCEM": PlayTypeCode.QXCEM,
  "TMSB": PlayTypeCode.TMSB,
  "TMZH": PlayTypeCode.TMZH,
  "XAB": PlayTypeCode.XAB,
  "ZHDXDS": PlayTypeCode.ZHDXDS,
  "ZXH": PlayTypeCode.ZXH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
