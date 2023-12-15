class UserRechargeListRespondModel {
  bool? success;
  String? message;
  int? code;
  UserRechargeListModel? data;

  UserRechargeListRespondModel(
      {this.success, this.message, this.code, this.data});

  UserRechargeListRespondModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new UserRechargeListModel.fromJson(json['data']) : null;
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

class UserRechargeListModel {
  int? page;
  int? limit;
  int? total;
  List<UserRechargeModel>? list;

  UserRechargeListModel({this.page, this.limit, this.total, this.list});

  UserRechargeListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    if (json['list'] != null) {
      list = <UserRechargeModel>[];
      json['list'].forEach((v) {
        list!.add(new UserRechargeModel.fromJson(v));
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

class UserRechargeModel {
  String? createTime;
  String? type;
  String? bankUsername;
  String? bankNumber;
  String? sn;
  int? money;
  int? status;
  String? statusName;

  UserRechargeModel(
      {this.createTime,
        this.type,
        this.bankUsername,
        this.bankNumber,
        this.sn,
        this.money,
        this.status,
        this.statusName});

  UserRechargeModel.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    type = json['type'];
    bankUsername = json['bank_username'];
    bankNumber = json['bank_number'];
    sn = json['sn'];
    money = json['money'];
    status = json['status'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    data['type'] = this.type;
    data['bank_username'] = this.bankUsername;
    data['bank_number'] = this.bankNumber;
    data['sn'] = this.sn;
    data['money'] = this.money;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    return data;
  }
}