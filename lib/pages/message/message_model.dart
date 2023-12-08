class MessageModel {
  final int id;
  final String title;
  final String link;
  final String image;
  final String content;
  // ignore: non_constant_identifier_names
  final String create_time;
  // ignore: non_constant_identifier_names
  final int is_read;

  // ignore: non_constant_identifier_names
  MessageModel(
      {required this.id,
      required this.title,
      required this.link,
      required this.image,
      required this.content,
      // ignore: non_constant_identifier_names
      required this.create_time,
      // ignore: non_constant_identifier_names
      required this.is_read});
}
