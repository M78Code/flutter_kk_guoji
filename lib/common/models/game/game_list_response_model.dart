class GameListResponseModel {
  bool? success;
  String? message;
  int? code;
  GameListModel? data;

  GameListResponseModel({this.success, this.message, this.code, this.data});

  GameListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new GameListModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GameListModel {
  List<GameModel>? list;
  int? totalCount;
  int? page;

  GameListModel({this.list, this.totalCount, this.page});

  GameListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <GameModel>[];
      json['list'].forEach((v) {
        list!.add(new GameModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['page'] = this.page;
    return data;
  }

}

class GameModel {
  int? id;
  int? gamePlatformId;
  int? gameCompanyId;
  String? gameCompanyCode;
  String? code;
  String? h5Code;
  int? type;
  int? cateType;
  String? name;
  String? image;
  int? sort;
  int? isHot;
  int? hotSort;
  String? gamePlatformName;
  int? isCollect;

  GameModel(
      {this.id,
        this.gamePlatformId,
        this.gameCompanyId,
        this.gameCompanyCode,
        this.code,
        this.h5Code,
        this.type,
        this.cateType,
        this.name,
        this.image,
        this.sort,
        this.isHot,
        this.hotSort,
        this.gamePlatformName,
        this.isCollect});

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gamePlatformId = json['game_platform_id'];
    gameCompanyId = json['game_company_id'];
    gameCompanyCode = json['game_company_code'];
    code = json['code'];
    h5Code = json['h5_code'];
    type = json['type'];
    cateType = json['cate_type'];
    name = json['name'];
    image = json['image'];
    sort = json['sort'];
    isHot = json['is_hot'];
    hotSort = json['hot_sort'];
    gamePlatformName = json['game_platform_name'];
    isCollect = json['is_collect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_platform_id'] = this.gamePlatformId;
    data['game_company_id'] = this.gameCompanyId;
    data['game_company_code'] = this.gameCompanyCode;
    data['code'] = this.code;
    data['h5_code'] = this.h5Code;
    data['type'] = this.type;
    data['cate_type'] = this.cateType;
    data['name'] = this.name;
    data['image'] = this.image;
    data['sort'] = this.sort;
    data['is_hot'] = this.isHot;
    data['hot_sort'] = this.hotSort;
    data['game_platform_name'] = this.gamePlatformName;
    data['is_collect'] = this.isCollect;
    return data;
  }
}
