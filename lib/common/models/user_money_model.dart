class UserMoneyModel {
  String? money;
  String? betMoney;

  UserMoneyModel({this.money, this.betMoney});

  UserMoneyModel.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    betMoney = json['bet_money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['money'] = this.money;
    data['bet_money'] = this.betMoney;
    return data;
  }
}