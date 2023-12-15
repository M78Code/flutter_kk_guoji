class KKRecordRateModel {
  int? id;
  String? name;
  String? icon;
  double? rate;
  // List<Null>? list;

  KKRecordRateModel({this.id, this.name, this.icon, this.rate,});

  KKRecordRateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    rate = json['rate'].toDouble();
    // if (json['list'] != null) {
    //   list = <Null>[];
    //   json['list'].forEach((v) {
    //     list!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['rate'] = this.rate;
    // if (this.list != null) {
    //   data['list'] = this.list!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
