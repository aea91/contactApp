import 'package:contacts/utils/application_constants.dart';

class IconConstants {
  static IconConstants? _instance;

  static IconConstants get instance {
    _instance ??= IconConstants._init();
    return _instance!;
  }

  IconConstants._init();

  // icons

  String get camera => toSvg("camera");
  String get gallery => toSvg("gallery");
  String get person => toSvg("person");
  String get success => toSvg("success");

  String get yok => toPng("yok");

  // functions
  String toPng(String name) => "${ApplicationConstants.ICON_ASSETS_PATH}$name.png";
  String toJpg(String name) => "${ApplicationConstants.ICON_ASSETS_PATH}$name.jpg";
  String toSvg(String name) => "${ApplicationConstants.ICON_ASSETS_PATH}$name.svg";
}
