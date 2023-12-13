// To parse this JSON data, do
//
//     final messageModel = messageModelFromMap(jsonString);
// ignore_for_file: unnecessary_this

import 'dart:convert';

MessageModel messageModelFromMap(String str) =>
    MessageModel.fromMap(json.decode(str));

String messageModelToMap(MessageModel data) => json.encode(data.toMap());

class MessageModel {
  bool success;
  String message;
  int code;
  Data data;

  MessageModel({
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        success: json["success"],
        message: json["message"],
        code: json["code"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "code": code,
        "data": data.toMap(),
      };
}

class Data {
  List<MessageListModel> list;
  int totalCount;
  int page;

  Data({
    required this.list,
    required this.totalCount,
    required this.page,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        list: List<MessageListModel>.from(
            json["list"].map((x) => MessageListModel.fromMap(x))),
        totalCount: json["totalCount"],
        page: json["page"],
      );

  Map<String, dynamic> toMap() => {
        "list": List<dynamic>.from(list.map((x) => x.toMap())),
        "totalCount": totalCount,
        "page": page,
      };
}

class MessageListModel {
  int id;
  String title;
  dynamic link;
  String linkTitle;
  String? image;
  List<dynamic> imgLink;
  String content;
  String createTime;
  int isRead;

  MessageListModel({
    required this.id,
    required this.title,
    required this.link,
    required this.linkTitle,
    required this.image,
    required this.imgLink,
    required this.content,
    required this.createTime,
    required this.isRead,
  });

  factory MessageListModel.fromMap(Map<String, dynamic> json) =>
      MessageListModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        linkTitle: json["link_title"],
        image: json["image"],
        imgLink: List<dynamic>.from(json["img_link"].map((x) => x)),
        content: json["content"],
        createTime: json["create_time"],
        isRead: json["is_read"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "link_title": linkTitle,
        "image": image,
        "img_link": List<dynamic>.from(imgLink.map((x) => x)),
        "content": content,
        "create_time": createTime,
        "is_read": isRead,
      };
}
