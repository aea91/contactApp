abstract class IPackageInfoManager {
  Future<void> init();
  String appName();
  String packageName();
  String version();
  String buildNumber();
}
