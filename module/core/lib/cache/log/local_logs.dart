import 'package:core/cache/log/log_local.dart';
import 'package:json_annotation/json_annotation.dart';
part 'local_logs.g.dart';

@JsonSerializable()
class LocalLogs {
  LocalLogs(this.logs);
  List<LogLocal> logs;

  factory LocalLogs.fromJson(Map<String, dynamic> json) => _$LocalLogsFromJson(json);
  toJson() => _$LocalLogsToJson(this);
}
