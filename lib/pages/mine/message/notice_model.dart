import 'dart:convert';

NoticeModel noticeModellFromMap(String str) =>
    NoticeModel.fromMap(json.decode(str));

String noticeModelToMap(NoticeModel data) => json.encode(data.toMap());

class NoticeModel {
  bool success;
  String message;
  int code;
  List<NoticeTypeModel> data;

  NoticeModel({
    required this.success,
    required this.message,
    required this.code,
    required this.data,
  });

  factory NoticeModel.fromMap(Map<String, dynamic> json) => NoticeModel(
        success: json["success"],
        message: json["message"],
        code: json["code"],
        data: List<NoticeTypeModel>.from(
            json["data"].map((x) => NoticeTypeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class NoticeTypeModel {
  int id;
  String name;
  NoticeTypeModel({
    required this.id,
    required this.name,
  });

  factory NoticeTypeModel.fromMap(Map<String, dynamic> json) => NoticeTypeModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
