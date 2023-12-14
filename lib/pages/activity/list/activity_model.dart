class CategoryModel {
  int index;
  String name;
  String? imgPath;

  CategoryModel({required this.index, required this.name, this.imgPath});
}

class ActivityModel {
  final int id;
  final String imageUrl;

  ActivityModel({required this.id, required this.imageUrl});
}
