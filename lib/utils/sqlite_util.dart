import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SqliteUtil {
   factory SqliteUtil() => _getInstance();


   static SqliteUtil get sharedInstance => _getInstance();
   // 静态变量_instance，存储唯一对象
   static SqliteUtil? _instance;

   SharedPreferences? _preferences;

   SqliteUtil._internal() {
     // 初始化
     initAsync();
   }

   // 获取对象
   static SqliteUtil _getInstance() {
     _instance ??= SqliteUtil._internal();
     return _instance!;
   }

   /// 异步初始化
   Future initAsync() async {
     _preferences ??= await SharedPreferences.getInstance();
   }

   static Future<SqliteUtil?> perInit() async {
     if (_instance == null) {
       //静态方法不能访问非静态变量所以需要创建变量再通过方法赋值回去
       SharedPreferences preferences = await SharedPreferences.getInstance();
       _instance = SqliteUtil._pre(preferences);
     }
     return _instance;
   }
   SqliteUtil._pre(SharedPreferences prefs) {
     _preferences = prefs;
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