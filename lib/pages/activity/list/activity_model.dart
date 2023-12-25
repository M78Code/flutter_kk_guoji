class CategoryModel {
  int? index;
  String? name;
  String? imgPath;
  String? currencyCode;

  CategoryModel({
    this.index,
    this.name,
    this.imgPath,
    this.currencyCode,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    currencyCode = json['currency_code'];
    name = currencyCode;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_code'] = currencyCode;
    return data;
  }
}

class ActivityModel {
  final int id;
  final String imageUrl;

  ActivityModel({required this.id, required this.imageUrl});
}
