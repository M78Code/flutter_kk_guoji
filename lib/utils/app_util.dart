import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class APPUtil {
  factory APPUtil() => _getInstance();

  static APPUtil get instance => _getInstance();

  static APPUtil? _instance;

  PackageInfo? _infoPlugin;

  APPUtil._initial() {
    initPlugin();
  }

  void initPlugin() async {
    _infoPlugin = await PackageInfo.fromPlatform();
  }

  static APPUtil _getInstance() {
    _instance ??= APPUtil._initial();
    return _instance!;
  }

  String? getAppVersion() {
    return _infoPlugin?.version;
  }

  String? getBuildNumber() {
    return _infoPlugin?.buildNumber;
  }
}
