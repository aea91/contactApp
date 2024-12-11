import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto_model.g.dart';

@JsonSerializable()
class UserDtoModel extends UserDtoEntity {
  UserDtoModel({
    required super.id,
    required super.createdAt,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.profileImageUrl,
  });

  factory UserDtoModel.fromJson(Map<String, dynamic> json) => _$UserDtoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoModelToJson(this);

  UserDtoEntity toEntity() => UserDtoEntity(
        id: id,
        createdAt: createdAt,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        profileImageUrl: profileImageUrl,
      );
}
