class CoinModel {
  String? currencyCode;

  CoinModel({this.currencyCode});

  CoinModel.fromJson(Map<String, dynamic> json) {
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_code'] = currencyCode;
    return data;
  }
}
