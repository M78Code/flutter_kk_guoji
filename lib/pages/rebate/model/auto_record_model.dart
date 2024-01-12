class KKAutoRecordModel {
  int? gameType;
  String? gameTypeName;
  double? rate;
  String? totalBet;
  String? totalMoney;
  // List<Null>? list;

  KKAutoRecordModel(
      {this.gameType,
        this.gameTypeName,
        this.rate,
        this.totalBet,
        this.totalMoney,
        });

  KKAutoRecordModel.fromJson(Map<String, dynamic> json) {
    gameType = json['game_type'];
    gameTypeName = json['game_type_name'];
    rate = double.tryParse(json['rate'].toString());
    totalBet = json['total_bet'];
    totalMoney = json['total_money'];
    // if (json['list'] != null) {
    //   list = <Null>[];
    //   json['list'].forEach((v) {
    //     list!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_type'] = this.gameType;
    data['game_type_name'] = this.gameTypeName;
    data['rate'] = this.rate;
    data['total_bet'] = this.totalBet;
    data['total_money'] = this.totalMoney;
    // if (this.list != null) {
    //   data['list'] = this.list!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
