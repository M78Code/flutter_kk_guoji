
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/scheduler.dart';


/// 配置服务
class ConfigService extends GetxService {
  // 单例
  static ConfigService get to => Get.find();

  PackageInfo? _platform;

  String get version => _platform?.version ?? '-';

  RxBool isSupportIconVisible = true.obs;

  // 多语言
  // Locale locale;
  // 是否首次打开
  // bool get isAlreadyOpen;

  @override
  void onInit() {
    super.onInit();
    getPlatform();
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  void toggleButtonVisibility(bool isVisible) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      this.isSupportIconVisible.value = isVisible;
    });
  }
}