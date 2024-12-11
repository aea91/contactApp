// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'local_file_io.dart';

class _FileManager {
  final String fileName = 'arpclean.json';
  static _FileManager? _instance;
  _FileManager._init();

  static _FileManager get instance {
    return _instance ??= _FileManager._init();
  }

  Future<Directory> documentsPath() async {
    final tempPath = (await getApplicationDocumentsDirectory()).path;
    return Directory(tempPath).create();
  }

  Future<String> filePath() async {
    final path = (await documentsPath()).path;
    return '$path/$fileName';
  }

  Future<File> getFile() async {
    final _filePath = await filePath();
    final userDocumentFile = File(_filePath);
    return userDocumentFile;
  }

  Future<Map?> fileReadAllData() async {
    try {
      var _filePath = await filePath();
      File userDocumentFile = File(_filePath);
      bool isExist = await userDocumentFile.exists();
      if (isExist) {
        final data = await userDocumentFile.readAsString();
        final jsonData = jsonDecode(data);

        return jsonData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<File> writeLocalModelInFile(BaseLocal local) async {
    String key = DateTime.now().toString();
    final _filePath = await filePath();
    final json = local.toJson();
    final model = <String, dynamic>{key: json};

    final oldData = await fileReadAllData();
    model.addAll(oldData as Map<String, dynamic>? ?? {});
    final newLocalData = jsonEncode(model);

    final userDocumentFile = File(_filePath);
    return await userDocumentFile.writeAsString(newLocalData, flush: true, mode: FileMode.write);
  }

  Future<String?> readOnlyKeyData(String key) async {
    final datas = await fileReadAllData();
    if (datas != null && datas[key] != null) {
      final model = datas[key] ?? {};
      final item = BaseLocal.fromJson(model);
      if (DateTime.now().isBefore(item.time!)) {
        return item.model;
      } else {
        await removeSingleItem(key);
        return null;
      }
    }
    return null;
  }

  /// Remove old key in  [Directory].
  Future<File?> removeSingleItem(String key) async {
    final tempDirectory = await fileReadAllData();
    if (tempDirectory == null) {
      return null;
    }
    final _key = tempDirectory.keys.isNotEmpty
        ? tempDirectory.keys.singleWhereOrNull((element) => element == key)
        : '';
    tempDirectory.remove(_key);
    final _filePath = await filePath();
    final userDocumentFile = File(_filePath);
    return await userDocumentFile.writeAsString(
      jsonEncode(tempDirectory),
      flush: true,
      mode: FileMode.write,
    );
  }

  /// Remove old [Directory].
  Future clearAllDirectoryItems() async {
    var tempDirectory = (await documentsPath());
    await tempDirectory.delete(recursive: true);
  }

  Future clearPastItems() async {
    Map? map = await fileReadAllData();
    if (map != null) {
      for (var key in map.keys) {
        BaseLocal data = BaseLocal.fromJson(map[key]);
        if (DateTime.now().isAfter(data.time!)) {
          await removeSingleItem(key);
        }
      }
    }
  }
}
