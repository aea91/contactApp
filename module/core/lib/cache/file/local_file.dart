import 'package:core/cache/file/IFileManager.dart';
import 'local_file_io.dart' as adapter;

class LocalFile extends IFileManager {
  final _customManager = adapter.createFileAdapter();
  @override
  Future<String?> getUserRequestDataOnString(String key) {
    return _customManager.getUserRequestDataOnString(key);
  }

  @override
  Future<bool> removeUserRequestCache(String key) {
    return _customManager.removeUserRequestCache(key);
  }

  @override
  Future<bool> removeUserRequestSingleCache(String key) {
    return _customManager.removeUserRequestSingleCache(key);
  }

  @override
  Future<void> removePastItems() async {
    _customManager.removePastItems();
  }

  @override
  Future<String?> getLogs() async {
    return await _customManager.getLogs();
  }

  @override
  Future<void> removeAllLogs() async {
    _customManager.removeAllLogs();
  }

  @override
  Future<void> saveFilePath() {
    throw UnimplementedError();
  }

  @override
  Future<bool> writeLog({
    required String log,
    required String tag,
    required Duration time,
    required String logLevel,
  }) {
    return _customManager.writeLog(log: log, tag: tag, time: time, logLevel: logLevel);
  }
}