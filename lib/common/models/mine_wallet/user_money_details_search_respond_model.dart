class UserMoneyDetailsSearchRespondModel {
  bool? success;
  String? message;
  int? code;
  UserMoneyDetailsSearchListModel? data;

  UserMoneyDetailsSearchRespondModel(
      {this.success, this.message, this.code, this.data});

  UserMoneyDetailsSearchRespondModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new UserMoneyDetailsSearchListModel.fromJson(json['data']) : null;
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

class UserMoneyDetailsSearchListModel {
  List<UserMoneyDetailsSearchModel>? list;
  int? totalCount;
  int? page;

  UserMoneyDetailsSearchListModel({this.list, this.totalCount, this.page});

  UserMoneyDetailsSearchListModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UserMoneyDetailsSearchModel>[];
      json['list'].forEach((v) {
        list!.add(new UserMoneyDetailsSearchModel.fromJson(v));
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

class UserMoneyDetailsSearchModel {
  int? id;
  String? amount;
  String? afterMoney;
  String? createTime;
  String? desc;
  String? profit;
  int? type;
  String? exchangeProfit;
  String? incomeExpenses;

  UserMoneyDetailsSearchModel(
      {this.id,
        this.amount,
        this.afterMoney,
        this.createTime,
        this.desc,
        this.profit,
        this.type,
        this.exchangeProfit,
        this.incomeExpenses});

  UserMoneyDetailsSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    afterMoney = json['after_money'];
    createTime = json['create_time'];
    desc = json['desc'];
    profit = json['profit'];
    type = json['type'];
    exchangeProfit = json['exchange_profit'];
    incomeExpenses = json['income_expenses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['after_money'] = this.afterMoney;
    data['create_time'] = this.createTime;
    data['desc'] = this.desc;
    data['profit'] = this.profit;
    data['type'] = this.type;
    data['exchange_profit'] = this.exchangeProfit;
    data['income_expenses'] = this.incomeExpenses;
    return data;
  }
}