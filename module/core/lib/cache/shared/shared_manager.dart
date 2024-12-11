// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:core/logger/contact_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_local.dart';

class SharedManager {
  SharedPreferences? preferences;
  static SharedManager? _instance;
  SharedManager._init();

  final String TAG = "SharedManager";

  static SharedManager? get instance {
    _instance ??= SharedManager._init();
    return _instance;
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveStringValue(String key, String value) async {
    return await preferences!.setString(key.toString(), value);
  }

  Future<bool> saveIntValue(String key, int value) async {
    return await preferences!.setInt(key.toString(), value);
  }

  Future<bool> saveDoubleValue(String key, double value) async {
    return await preferences!.setDouble(key.toString(), value);
  }

  Future<bool> saveBooleanValue(String key, bool value) async {
    return await preferences!.setBool(key.toString(), value);
  }

  String? getStringValue(String key) {
    return preferences!.getString(key.toString());
  }

  int? getIntValue(String key) {
    return preferences!.getInt(key.toString());
  }

  double? getDoubleValue(String key) {
    return preferences!.getDouble(key.toString());
  }

  bool? getBooleanValue(String key) {
    return preferences!.getBool(key.toString());
  }

  Future<bool?> setJsonModel<T>(
      {required String key, required T model, required Duration duration}) async {
    BaseLocal local = BaseLocal(model: model, time: DateTime.now().add(duration));
    var json = jsonEncode(local);
    if (model != null && json.isNotEmpty) {
      ContactLogger.instance!.info(TAG, "model is saved json: $json");
      return await preferences!.setString(key, json);
    }
    return false;
  }

  dynamic getJsonModel({
    required String key,
    required Function(Map<String, dynamic> json) fromJson,
  }) async {
    ContactLogger.instance!.info(TAG, "key: $key");
    var jsonString = preferences?.getString(key);
    print("cache:::: $jsonString");
    ContactLogger.instance!.info(TAG, jsonString ?? "json string null");
    if (jsonString != null) {
      var jsonModel = jsonDecode(jsonString);
      final baseLocalModel = BaseLocal.fromJson(jsonModel);
      ContactLogger.instance!
          .info(TAG, "date: ${baseLocalModel.time} model: ${baseLocalModel.model}");
      if (DateTime.now().isBefore(baseLocalModel.time!)) {
        Map<String, dynamic> data = BaseLocal.fromJson(jsonModel).model;
        return fromJson(data);
      } else {
        await removeModel(key);
      }
    }
    return null;
  }

  Future<bool> removeModel(String key) async {
    return await preferences!.remove(key);
  }

  Set<String> getKeys() {
    return preferences!.getKeys();
  }

  Future removeAll() async {
    await preferences!.clear();
  }
}
