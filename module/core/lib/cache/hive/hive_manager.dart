import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../shared/base_local.dart';

class HiveManager {
  Box? box;
  static HiveManager? _instance;
  HiveManager._init();

  static HiveManager? get instance {
    _instance ??= HiveManager._init();
    return _instance;
  }

  Future init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    box = await Hive.openBox("hiveCache");
  }

  Future setJsonModel<T>(String key, T model, Duration duration) async {
    BaseLocal local = BaseLocal(model: model, time: DateTime.now().add(duration));
    var json = jsonEncode(local);
    if (model != null && json.isNotEmpty) {
      await box!.put(key, json);
    }
  }

  dynamic getJsonModel(dynamic model, String key) async {
    var jsonString = await box!.get(key);
    if (jsonString != null) {
      var jsonModel = jsonDecode(jsonString);
      final baseLocalModel = BaseLocal.fromJson(jsonModel);
      if (DateTime.now().isBefore(baseLocalModel.time!)) {
        Map<String, dynamic> data = BaseLocal.fromJson(jsonModel).model;
        return model.fromJson(data);
      } else {
        await removeModel(key);
      }
    }
    return null;
  }

  Future<void> removeModel(String key) async {
    await box!.delete(key);
  }
}
