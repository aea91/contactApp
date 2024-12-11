import 'package:package_info_plus/package_info_plus.dart';
import 'package:packages/package_info/interface_package_info_manager.dart';

class PackageInfoManager implements IPackageInfoManager {
  static PackageInfoManager? _instance;
  late PackageInfo _packageInfo;
  static PackageInfoManager get instance {
    if (_instance == null) {}
    _instance ??= PackageInfoManager._init();
    return _instance!;
  }

  PackageInfoManager._init();

  @override
  Future init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  String appName() {
    return _packageInfo.appName;
  }

  @override
  String buildNumber() {
    return _packageInfo.buildNumber;
  }

  @override
  String packageName() {
    return _packageInfo.packageName;
  }

  @override
  String version() {
    return _packageInfo.version;
  }

  rer() {}
}
