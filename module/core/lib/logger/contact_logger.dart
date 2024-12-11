// ignore_for_file: non_constant_identifier_names

import 'package:core/cache/log/log_local_file.dart';
import 'package:core/logger/interface_contact_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class ContactLogger implements IContactLogger {
  late Logger _logger;
  bool _isCacheLog = false;
  late Duration _logDuration;
  static ContactLogger? _instance;
  static ContactLogger? get instance {
    _instance ??= ContactLogger._init();
    return _instance!;
  }

  ContactLogger._init();
  init({required bool isCacheLog, required Duration logDuration}) {
    _logger = Logger();
    _isCacheLog = isCacheLog;
    _logDuration = logDuration;
  }

  @override
  error(String TAG, String error) {
    if (kDebugMode) {
      _logger.e('$TAG: $error');
    }
    if (_isCacheLog) {
      LogLocalFile().writeLog(log: error, tag: TAG, time: _logDuration, logLevel: "error");
    }
  }

  @override
  info(String TAG, String info) {
    if (kDebugMode) {
      _logger.i('$TAG: $info');
    }

    if (_isCacheLog) {
      LogLocalFile().writeLog(log: info, tag: TAG, time: _logDuration, logLevel: "info");
    }
  }

  @override
  warning(String TAG, String warning) {
    if (kDebugMode) {
      _logger.w('$TAG: $warning');
    }

    if (_isCacheLog) {
      LogLocalFile().writeLog(log: warning, tag: TAG, time: _logDuration, logLevel: "warning");
    }
  }

  Future<String?> getLogs() async {
    return await LogLocalFile().getLogs();
  }
}
