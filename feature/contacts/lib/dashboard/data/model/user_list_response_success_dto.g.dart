// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response_success_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponseSuccessDto _$UserListResponseSuccessDtoFromJson(
        Map<String, dynamic> json) =>
    UserListResponseSuccessDto(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserDtoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseSuccessDtoToJson(
        UserListResponseSuccessDto instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
