// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';

const _whiteColor = Color(0xffffffff);
const _pageColor = Color(0xffF4F4F4);
const _greyColor = Color(0xffB4B4B4);
const _blackColor = Color(0xff000000);
const _blueColor = Color(0xff0075FF);
const _greenColor = Color(0xff008505);
const _redDeleteColor = Color(0xffff0000);

const _colorScheme = ColorScheme(
  primary: _blackColor,
  secondary: _pageColor,
  onPrimary: _blueColor,
  onSurface: _whiteColor,
  error: _redDeleteColor,
  background: _pageColor,
  onSecondary: _greenColor,
  onBackground: _blackColor,
  onError: _whiteColor,
  surface: _pageColor,
  brightness: Brightness.light,
);

final ThemeData ContactTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Sf-pro-display',
  brightness: Brightness.light,
  primaryColor: _blackColor,
  primaryColorLight: _blackColor.withOpacity(0.1),
  primaryColorDark: Colors.black,
  //Page Background Color
  scaffoldBackgroundColor: _pageColor,
  cardColor: const Color(0xffffffff),
  dividerColor: _greyColor,
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0xffffffff),
  disabledColor: const Color(0xffF4F4F4),
  secondaryHeaderColor: const Color(0xfffbe9ec), // beyaz
  dialogBackgroundColor: const Color(0xffffffff),
  indicatorColor: _blackColor,
  hintColor: _greyColor,

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: _blackColor,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      color: _blackColor,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      color: _blackColor,
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: _blackColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: _greyColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: _greyColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: _redDeleteColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: true,
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: _greyColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: _greyColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: _greyColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: _pageColor,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: _blackColor),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _pageColor,
      foregroundColor: _blackColor,
      fixedSize: const Size(370, 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  iconTheme: const IconThemeData(
    color: _blackColor,
    opacity: 1,
    size: 24,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    foregroundColor: _blackColor,
    elevation: 0,
  ),

  colorScheme: _colorScheme,
);
