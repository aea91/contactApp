// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) => BaseResponseModel(
      data: json['data'],
      messages: (json['messages'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: (json['status'] as num?)?.toInt(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) => <String, dynamic>{
      'data': instance.data,
      'messages': instance.messages,
      'status': instance.status,
      'success': instance.success,
    };
