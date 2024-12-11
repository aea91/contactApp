import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static PermissionManager? _instace;
  static PermissionManager get instance {
    _instace ??= _instace = PermissionManager._init();
    return _instace!;
  }

  PermissionManager._init();

  /// service status - only when in use
  Future<bool> isPermissionLocationWhenInUseServiceStatusEnabled() async {
    return Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  /// service status - only always
  Future<bool> isPermissionLocationAlwaysServiceStatusEnabled() async {
    return Permission.locationAlways.serviceStatus.isEnabled;
  }

  /// service status - always and when in use
  Future<bool> isPermissionLocationServiceStatusEnabled() async {
    return Permission.location.serviceStatus.isEnabled;
  }

  /// user - only when in use
  Future<bool> isPermissionLocationWhenInUseGranted() async {
    return Permission.locationWhenInUse.isGranted;
  }

  /// user - only always
  Future<bool> isPermissionLocationAlwaysGranted() async {
    return Permission.locationAlways.isGranted;
  }

  /// user - always and when in use
  Future<bool> isPermissionLocationGranted() async {
    return Permission.location.isGranted;
  }

  Future<bool> isPermissionLocationPermenantlyDenied() async {
    return await Permission.location.isPermanentlyDenied;
  }

  Future<bool> isPermissionLocatioAlwaysPermenantlyDenied() async {
    return await Permission.locationAlways.isPermanentlyDenied;
  }

  Future<bool> openApplicationSettings() async {
    // The user opted to never again see the permission request dialog for this
    // app. The only way to change the permission's status now is to let the
    // user manually enable it in the system settings.
    return await openAppSettings();
  }

  Future<PermissionStatus> requestLocation() async {
    return await Permission.location.request();
  }

  Future<PermissionStatus> requestLocationWhenInUse() async {
    return await Permission.locationWhenInUse.request();
  }

  Future<PermissionStatus> requestLocationAlways() async {
    return await Permission.locationAlways.request();
  }

  Future<PermissionStatus> requestStorage() async {
    PermissionStatus status = await Permission.storage.request();
    print(status);
    return status;
  }
}
