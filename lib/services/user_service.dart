import 'package:get/get.dart';


class UserService extends GetxService {
  static UserService get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  /// 是否登录
  bool get isLogin => _isLogin.value;


}