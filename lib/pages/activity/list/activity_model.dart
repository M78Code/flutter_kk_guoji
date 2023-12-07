class CategoryModel {
  int index;
  String name;

  CategoryModel({
    required this.index,
    required this.name
  });
}

class ActivityModel {
  final int id;
  final String imageUrl;

  ActivityModel({required this.id, required this.imageUrl});
}