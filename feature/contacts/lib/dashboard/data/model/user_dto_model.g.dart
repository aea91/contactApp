// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDtoModel _$UserDtoModelFromJson(Map<String, dynamic> json) => UserDtoModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$UserDtoModelToJson(UserDtoModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'id': instance.id,
      'createdAt': instance.createdAt,
    };
