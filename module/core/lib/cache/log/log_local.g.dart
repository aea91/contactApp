// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogLocal _$LogLocalFromJson(Map<String, dynamic> json) => LogLocal(
      log: json['log'] as String,
      tag: json['tag'] as String,
      time: json['time'] as String,
      logLevel: json['logLevel'] as String,
    );

Map<String, dynamic> _$LogLocalToJson(LogLocal instance) => <String, dynamic>{
      'log': instance.log,
      'tag': instance.tag,
      'time': instance.time,
      'logLevel': instance.logLevel,
    };
