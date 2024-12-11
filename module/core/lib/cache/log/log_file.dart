// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'log_local_file_io.dart';

class _LogFileManager {
  final String fileName = 'arpclean.json';
  static _LogFileManager? _instance;
  _LogFileManager._init();

  static _LogFileManager get instance {
    return _instance ??= _LogFileManager._init();
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
    final filepath = await filePath();
    final userDocumentFile = File(filepath);
    return userDocumentFile;
  }

  Future<Map?> fileReadAllData() async {
    try {
      var filepath = await filePath();
      File? userDocumentFile = File(filepath);
      bool isExist = await userDocumentFile.exists();
      if (isExist) {
        final data = await userDocumentFile.readAsString();
        if (data.isNotEmpty) {
          final jsonData = jsonDecode(data);
          return jsonData;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<File> writeLocalModelInFile({required String key, required LogLocal local}) async {
    final filepath = await filePath();
    final json = local.toJson();
    final model = <String, dynamic>{key: json};

    final oldData = await fileReadAllData();
    model.addAll(oldData as Map<String, dynamic>? ?? {});
    final newLocalData = jsonEncode(model);

    final userDocumentFile = File(filepath);
    return await userDocumentFile.writeAsString(newLocalData, flush: true, mode: FileMode.write);
  }

  Future<String?> readOnlyKeyData(String key) async {
    final datas = await fileReadAllData();
    if (datas != null && datas[key] != null) {
      final model = datas[key] ?? {};
      final item = LogLocal.fromJson(model);
      if (DateTime.now().isBefore(DateTime.parse(key).add(const Duration(minutes: 1)))) {
        return item.log;
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
    final filepath = await filePath();
    final userDocumentFile = File(filepath);
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
        if (DateTime.now().isAfter(DateTime.parse(key).add(const Duration(minutes: 1)))) {
          await removeSingleItem(key);
        }
      }
    }
  }

  Future<String?> getAllLogData() async {
    Map? map = await fileReadAllData();
    if (map != null) {
      return jsonEncode(map);
    }
    return null;
  }

  Future saveFilePath() async {
    final String filepath = await filePath();
    await SharedManager.instance!.saveStringValue('filePath', filepath);
  }
}
