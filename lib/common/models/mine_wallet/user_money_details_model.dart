class UserMoneyDetailsRespondModel {
  bool? success;
  String? message;
  int? code;
  UserMoneyDetailsModel? data;

  UserMoneyDetailsRespondModel(
      {this.success, this.message, this.code, this.data});

  UserMoneyDetailsRespondModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new UserMoneyDetailsModel.fromJson(json['data']) : null;
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

class UserMoneyDetailsModel {
  int? id;
  String? username;
  String? totalBonus;
  String? totalGif;
  String? agentCommissTotal;
  String? totalRebate;
  String? totalRecharge;
  String? totalWithdraw;

  UserMoneyDetailsModel(
      {this.id,
        this.username,
        this.totalBonus,
        this.totalGif,
        this.agentCommissTotal,
        this.totalRebate,
        this.totalRecharge,
        this.totalWithdraw});

  UserMoneyDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    totalBonus = json['total_bonus'];
    totalGif = json['total_gif'];
    agentCommissTotal = json['agent_commiss_total'];
    totalRebate = json['total_rebate'];
    totalRecharge = json['total_recharge'];
    totalWithdraw = json['total_withdraw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['total_bonus'] = this.totalBonus;
    data['total_gif'] = this.totalGif;
    data['agent_commiss_total'] = this.agentCommissTotal;
    data['total_rebate'] = this.totalRebate;
    data['total_recharge'] = this.totalRecharge;
    data['total_withdraw'] = this.totalWithdraw;
    return data;
  }
}