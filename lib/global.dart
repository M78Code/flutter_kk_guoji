
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/services/config_service.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/services/http_service.dart';

class Global {
  static Future<void> init() async {

    Get.put<ConfigService>(ConfigService());
    Get.put<UserService>(UserService());
    Get.put<SqliteService>(SqliteService());
    Get.put<HttpService>(HttpService());

    // 全局设置
    EasyRefresh.defaultHeaderBuilder = () => MaterialHeader();
    EasyRefresh.defaultFooterBuilder = () => MaterialFooter(noMoreIcon: Text('没有更多数据', style: TextStyle(color: Colors.white),));
  }
}