import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserInfoModel {
  int? id;
  int? uuid;
  String? username;
  String? money;
  String? portrait;
  int? userGroupId;
  String? userNick;
  String? email;
  String? mobile;
  String? qq;
  String? weixin;
  String? skype;
  String? telegram;
  String? whatsapp;
  String? strongBoxAmount;
  int? strongBoxStatus;
  int? level;
  int? boxStatus;
  int? boxPwd;
  int? withdrawPwdStatus;
  String? url;

  UserInfoModel(
      {this.id,
      this.uuid,
      this.username,
      this.money,
      this.portrait,
      this.userGroupId,
      this.userNick,
      this.email,
      this.mobile,
      this.qq,
      this.weixin,
      this.skype,
      this.telegram,
      this.whatsapp,
      this.strongBoxAmount,
      this.strongBoxStatus,
      this.level,
      this.boxStatus,
      this.boxPwd,
      this.withdrawPwdStatus,
      this.url});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    username = json['username'];
    money = json['money'];
    portrait = json['portrait'];
    userGroupId = json['user_group_id'];
    userNick = json['user_nick'];
    email = json['email'];
    mobile = json['mobile'];
    qq = json['qq'];
    weixin = json['weixin'];
    skype = json['skype'];
    telegram = json['telegram'];
    whatsapp = json['whatsapp'];
    strongBoxAmount = json['strong_box_amount'];
    strongBoxStatus = json['strong_box_status'];
    level = json['level'];
    boxStatus = json['box_status'];
    boxPwd = json['box_pwd'];
    withdrawPwdStatus = json['withdraw_pwd_status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['money'] = this.money;
    data['portrait'] = this.portrait;
    data['user_group_id'] = this.userGroupId;
    data['user_nick'] = this.userNick;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['qq'] = this.qq;
    data['weixin'] = this.weixin;
    data['skype'] = this.skype;
    data['telegram'] = this.telegram;
    data['whatsapp'] = this.whatsapp;
    data['strong_box_amount'] = this.strongBoxAmount;
    data['strong_box_status'] = this.strongBoxStatus;
    data['level'] = this.level;
    data['box_status'] = this.boxStatus;
    data['box_pwd'] = this.boxPwd;
    data['withdraw_pwd_status'] = this.withdrawPwdStatus;
    data["url"] = this.url;
    return data;
  }

}
