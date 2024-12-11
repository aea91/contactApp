import 'package:flutter/material.dart';

import '../cache/shared/shared_manager.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double height(double value) => mediaQuery.size.height * value;
  double width(double value) => mediaQuery.size.width * value;

  /// 4.h
  double get lowestH => 4;

  /// 8.h
  double get lowH => 8;

  /// 12.h
  double get normalH => 12;

  /// 16.h
  double get mediumH => 16;

  /// 18.h
  double get largeH => 18;

  /// 24.h
  double get xlargeH => 24;

  /// 32.h
  double get xxlargeH => 32;

  /// 4.w
  double get lowestW => 4;

  /// 8.w
  double get lowW => 8;

  /// 12.w
  double get normalW => 12;

  /// 16.w
  double get mediumW => 16;

  /// 18.w
  double get largeW => 18;

  /// 24.w
  double get xlargeW => 24;

  /// 32.w
  double get xxlargeW => 32;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ButtonThemeData get buttonTheme => theme.buttonTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingPage => EdgeInsets.only(left: 30, right: 30);
  EdgeInsets get paddingLeft => EdgeInsets.only(left: 16);
  EdgeInsets get paddingRight => EdgeInsets.only(right: 16);
}

extension SharedPreferencesExtension on BuildContext {
  saveString(String key, value) async {
    await SharedManager.instance!.saveStringValue(key, value);
  }
}

extension SpaceExtension on BuildContext {
  Widget spacelow(BuildContext context) => SizedBox(height: context.height(lowH));
  Widget spaceMedium(BuildContext context) => SizedBox(height: context.height(mediumH));
  Widget spaceNormal(BuildContext context) => SizedBox(height: context.height(normalH));
  Widget spaceHigh(BuildContext context) => SizedBox(height: context.height(xlargeH));
  Widget spaceH(double height) => SizedBox(height: height);
}
