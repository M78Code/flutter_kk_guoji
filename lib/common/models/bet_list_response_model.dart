class BetListResponseModel {
  bool? success;
  String? message;
  int? code;
  BetListModel? data;

  BetListResponseModel({this.success, this.message, this.code, this.data});

  BetListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new BetListModel.fromJson(json['data']) : null;
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

class BetListModel {
  int? page;
  int? limit;
  int? total;
  List<BetModel>? list;

  BetListModel({this.page, this.limit, this.total, this.list});

  BetListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    if (json['list'] != null) {
      list = <BetModel>[];
      json['list'].forEach((v) {
        list!.add(new BetModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BetModel {
  String? createTime;
  String? endTime;
  String? gameTypeName;
  int? gameTypeId;
  String? gameName;
  int? gameRealId;
  String? gameBet;
  String? gameSn;
  String? gameWin;
  String? gameProfit;
  int? gameWinStatus;
  String? gameWinStatusName;

  BetModel(
      {this.createTime,
        this.endTime,
        this.gameTypeName,
        this.gameTypeId,
        this.gameName,
        this.gameRealId,
        this.gameBet,
        this.gameSn,
        this.gameWin,
        this.gameProfit,
        this.gameWinStatus,
        this.gameWinStatusName});

  BetModel.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    endTime = json['end_time'];
    gameTypeName = json['game_type_name'];
    gameTypeId = json['game_type_id'];
    gameName = json['game_name'];
    gameRealId = json['game_real_id'];
    gameBet = json['game_bet'];
    gameSn = json['game_sn'];
    gameWin = json['game_win'];
    gameProfit = json['game_profit'];
    gameWinStatus = json['game_win_status'];
    gameWinStatusName = json['game_win_status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    data['end_time'] = this.endTime;
    data['game_type_name'] = this.gameTypeName;
    data['game_type_id'] = this.gameTypeId;
    data['game_name'] = this.gameName;
    data['game_real_id'] = this.gameRealId;
    data['game_bet'] = this.gameBet;
    data['game_sn'] = this.gameSn;
    data['game_win'] = this.gameWin;
    data['game_profit'] = this.gameProfit;
    data['game_win_status'] = this.gameWinStatus;
    data['game_win_status_name'] = this.gameWinStatusName;
    return data;
  }
}