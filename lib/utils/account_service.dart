
import 'package:kkguoji/utils/sqlite_util.dart';

import '../services/cache_key.dart';

class AccountService {
  // 如果一个函数的构造方法并不总是返回一个新的对象的时候，可以使用factory，
  // 比如从缓存中获取一个实例并返回或者返回一个子类型的实例

  // 工厂方法构造函数
  factory AccountService() => _getInstance();

  // instance的getter方法，通过AccountService.instance获取对象
  static AccountService get sharedInstance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static AccountService? _instance;
  bool? _isLogin;


  // 私有的命名式构造方法，通过它可以实现一个类可以有多个构造函数，
  // 子类不能继承internal不是关键字，可定义其他名字
  AccountService._internal() {
    // 初始化
  }


  // 获取对象
  static AccountService _getInstance() {
    _instance ??= AccountService._internal();
    return _instance!;
  }

  bool get isLogin {

      if(SqliteUtil().getString(CacheKey.apiToken) != null) {
         _isLogin = true;
      }else {
        _isLogin = false;
      }
      return _isLogin!;
  }


}
