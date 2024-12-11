// ignore_for_file: file_names

abstract class ILogFileManager {
  Future<bool> writeLog({
    required String log,
    required String tag,
    required Duration time,
    required String logLevel,
  });
  Future<String?> getUserRequestDataOnString(String key);
  Future<bool> removeUserRequestSingleCache(String key);
  Future<bool> removeUserRequestCache(String key);
  Future<void> removePastItems();
  Future<void> removeAllItems();
  Future<String?> getLogs();
  Future<void> saveFilePath();
}
