// To parse this JSON data, do
//
//     final recommendGameModel = recommendGameModelFromJson(jsonString);

import 'dart:convert';

RecommendGameModel recommendGameModelFromJson(String str) => RecommendGameModel.fromJson(json.decode(str));

String recommendGameModelToJson(RecommendGameModel data) => json.encode(data.toJson());

class RecommendGameModel {
  bool success;
  String message;
  int code;
  Data data;

  RecommendGameModel({
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  factory RecommendGameModel.fromJson(Map<String, dynamic> json) => RecommendGameModel(
    success: json["success"],
    message: json["message"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  List<RecommendList> list;
  int totalCount;
  int page;

  Data({
    required this.list,
    required this.totalCount,
    required this.page,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: List<RecommendList>.from(json["list"].map((x) => RecommendList.fromJson(x))),
    totalCount: json["totalCount"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "totalCount": totalCount,
    "page": page,
  };
}

class RecommendList {
  int id;
  int gamePlatformId;
  int gameCompanyId;
  String gameCompanyCode;
  String code;
  String h5Code;
  int type;
  int cateType;
  String name;
  String image;
  int sort;
  int isHot;
  int hotSort;
  String gamePlatformName;
  int isCollect;

  RecommendList({
    required this.id,
    required this.gamePlatformId,
    required this.gameCompanyId,
    required this.gameCompanyCode,
    required this.code,
    required this.h5Code,
    required this.type,
    required this.cateType,
    required this.name,
    required this.image,
    required this.sort,
    required this.isHot,
    required this.hotSort,
    required this.gamePlatformName,
    required this.isCollect,
  });

  factory RecommendList.fromJson(Map<String, dynamic> json) => RecommendList(
    id: json["id"],
    gamePlatformId: json["game_platform_id"],
    gameCompanyId: json["game_company_id"],
    gameCompanyCode: json["game_company_code"],
    code: json["code"],
    h5Code: json["h5_code"],
    type: json["type"],
    cateType: json["cate_type"],
    name: json["name"],
    image: json["image"],
    sort: json["sort"],
    isHot: json["is_hot"],
    hotSort: json["hot_sort"],
    gamePlatformName: json["game_platform_name"],
    isCollect: json["is_collect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game_platform_id": gamePlatformId,
    "game_company_id": gameCompanyId,
    "game_company_code": gameCompanyCode,
    "code": code,
    "h5_code": h5Code,
    "type": type,
    "cate_type": cateType,
    "name": name,
    "image": image,
    "sort": sort,
    "is_hot": isHot,
    "hot_sort": hotSort,
    "game_platform_name": gamePlatformName,
    "is_collect": isCollect,
  };
}
