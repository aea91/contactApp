// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:core/cache/log/log_local.dart';
import 'package:core/cache/shared/shared_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'ILogFileManager.dart';
part 'log_file.dart';

ILogFileManager createFileAdapter() => _LogLocalFileIO();

class _LogLocalFileIO extends ILogFileManager {
  final _LogFileManager _fileManager = _LogFileManager.instance;

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
  Future<bool> writeLog({
    required String tag,
    required String log,
    required Duration time,
    required String logLevel,
  }) async {
    String key = DateTime.now().add(time).toString();

    final localModel = LogLocal(
      log: log,
      tag: tag,
      time: DateTime.now().toString(),
      logLevel: logLevel,
    );
    await _fileManager.writeLocalModelInFile(key: key, local: localModel);
    return true;
  }

  @override
  Future<void> removePastItems() async {
    await _fileManager.clearPastItems();
  }

  @override
  Future<String?> getLogs() async {
    return _fileManager.getAllLogData();
  }

  @override
  Future<void> removeAllItems() async {
    await _fileManager.clearAllDirectoryItems();
  }

  @override
  Future<void> saveFilePath() async {
    await _fileManager.saveFilePath();
  }
}
