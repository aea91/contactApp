// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:core/cache/file/IFileManager.dart';
import 'package:collection/collection.dart';
import 'package:core/cache/log/log_local.dart';
import 'package:path_provider/path_provider.dart';

import '../shared/base_local.dart';
part 'file.dart';

IFileManager createFileAdapter() => _LocalFileIO();

class _LocalFileIO extends IFileManager {
  final _FileManager _fileManager = _FileManager.instance;

  @override
  Future<String?> getUserRequestDataOnString(String key) {
    return _fileManager.readOnlyKeyData(key);
  }

  @override
  Future<bool> removeUserRequestCache(String key) async {
    await _fileManager.clearAllDirectoryItems();
    return true;
  }

  @override
  Future<bool> removeUserRequestSingleCache(String key) async {
    await _fileManager.removeSingleItem(key);
    return true;
  }

  @override
  Future<void> removePastItems() async {
    await _fileManager.clearPastItems();
  }

  @override
  Future<String?> getLogs() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllLogs() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveFilePath() {
    throw UnimplementedError();
  }

  @override
  Future<bool> writeLog({
    required String log,
    required String tag,
    required Duration? time,
    required String logLevel,
  }) async {
    if (time == null) {
      return false;
    } else {
      final localModel = BaseLocal(
          model: LogLocal(
            log: log,
            tag: tag,
            time: DateTime.now().add(time).toString(),
            logLevel: logLevel,
          ),
          time: DateTime.now().add(time));
      await _fileManager.writeLocalModelInFile(localModel);
      return true;
    }
  }
}
