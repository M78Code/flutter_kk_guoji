class GameLogin {
  String? url;
  String? exCurrency;

  GameLogin({this.url, this.exCurrency});

  GameLogin.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    exCurrency = json['ex_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['ex_currency'] = this.exCurrency;
    return data;
  }
}