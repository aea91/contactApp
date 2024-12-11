import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoManager {
  static DeviceInfoManager? _instance;
  late DeviceInfoPlugin _deviceInfo;
  late AndroidDeviceInfo _androidDeviceInfo;
  late IosDeviceInfo _iosDeviceInfo;
  static DeviceInfoManager get instance {
    _instance ??= DeviceInfoManager._init();
    return _instance!;
  }

  DeviceInfoManager._init();

  Future<void> init() async {
    _deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
    }
  }

  String? getDeviceId() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo.id;
    } else if (Platform.isIOS) {
      return _iosDeviceInfo.identifierForVendor ?? _iosDeviceInfo.identifierForVendor;
    } else {
      return "emptyDeviceId";
    }
  }
}
