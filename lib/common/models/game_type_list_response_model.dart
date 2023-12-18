class GameTypeListResponseModel {
  bool? success;
  String? message;
  int? code;
  List<GameTypeModel>? data;

  GameTypeListResponseModel({this.success, this.message, this.code, this.data});

  GameTypeListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <GameTypeModel>[];
      json['data'].forEach((v) {
        data!.add(new GameTypeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameTypeModel {
  int? id;
  String? name;
  int? sort;
  int? status;
  int? middleStatus;
  String? icon;
  String? iconClick;
  String? nameKey;

  GameTypeModel(
      {this.id,
        this.name,
        this.sort,
        this.status,
        this.middleStatus,
        this.icon,
        this.iconClick,
        this.nameKey});

  GameTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    status = json['status'];
    middleStatus = json['middle_status'];
    icon = json['icon'];
    iconClick = json['icon_click'];
    nameKey = json['name_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['status'] = this.status;
    data['middle_status'] = this.middleStatus;
    data['icon'] = this.icon;
    data['icon_click'] = this.iconClick;
    data['name_key'] = this.nameKey;
    return data;
  }
}