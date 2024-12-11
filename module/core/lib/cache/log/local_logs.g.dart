// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalLogs _$LocalLogsFromJson(Map<String, dynamic> json) => LocalLogs(
      (json['logs'] as List<dynamic>)
          .map((e) => LogLocal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalLogsToJson(LocalLogs instance) => <String, dynamic>{
      'logs': instance.logs,
    };
