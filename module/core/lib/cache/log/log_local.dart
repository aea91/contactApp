import 'package:json_annotation/json_annotation.dart';
part 'log_local.g.dart';

@JsonSerializable()
class LogLocal {
  String log;
  String tag;
  String time;
  String logLevel;

  LogLocal({
    required this.log,
    required this.tag,
    required this.time,
    required this.logLevel,
  });

  factory LogLocal.fromJson(Map<String, dynamic> json) => _$LogLocalFromJson(json);
  toJson() => _$LogLocalToJson(this);
}
