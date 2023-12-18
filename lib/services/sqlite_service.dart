

import 'dart:convert';

import 'package:get/get.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/websocket_util.dart';

class SqliteService extends GetxService {
  static SqliteService get to => Get.find();


  SharedPreferences? _preferences;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPreferences();
  }

  Future<void> getPreferences() async{
    _preferences = await SharedPreferences.getInstance();
    if(getString(CacheKey.apiToken) != null) {
      Get.find<UserService>().isLogin = true;
      Get.find<UserService>().fetchUserInfo();
      Get.find<UserService>().fetchUserMoney();
    }else {
      Get.find<UserService>().isLogin = false;
    }
    WebSocketUtil().connetSocket();

  }


  ///设置String类型的
  void setString(key, value) {
    _preferences?.setString(key, value);
  }
  ///设置setStringList类型的
  void setStringList(key, value) {
    _preferences?.setStringList(key, value);
  }
  List<String> getStringList(key) {
    return _preferences?.getStringList(key) ?? [];
  }
  ///设置setBool类型的
  void setBool(key, value) {
    _preferences?.setBool(key, value);
  }
  bool? getBool(key) {
    return _preferences?.getBool(key);
  }
  int? getInt(key) {
    return _preferences?.getInt(key);
  }
  String? getString(key) {
    return _preferences?.getString(key);
  }
  ///设置setDouble类型的
  void setDouble(key, value) {
    _preferences?.setDouble(key, value);
  }

  ///设置setInt类型的
  void setInt(key, value) {
    _preferences?.setInt(key, value);
  }
  ///存储Json类型的
  void setJson(key, value) {
    value = jsonEncode(value);
    _preferences?.setString(key, value);
  }
  ///通过泛型来获取数据
  T? get<T>(key) {
    var result = _preferences?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
  ///获取JSON
  Map<String, dynamic>? getJson(key) {
    String? result = _preferences?.getString(key);
    if(result != null) {
      if (result!.isNotEmpty) {
        return jsonDecode(result!);
      }
    }
    return null;
  }

  void clean() {
    _preferences?.clear();
  }
  ///移除某一个
  void remove(key) {
    _preferences?.remove(key);
  }
}