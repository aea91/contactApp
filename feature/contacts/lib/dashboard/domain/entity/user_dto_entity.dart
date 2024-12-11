import 'package:contacts/dashboard/domain/entity/user_entity.dart';

class UserDtoEntity extends UserEntity {
  UserDtoEntity({
    required this.id,
    required this.createdAt,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.profileImageUrl,
  });

  final String? id;
  final String? createdAt;

  UserDtoEntity copyWith({
    String? id,
    String? createdAt,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return UserDtoEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDtoEntity &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        profileImageUrl.hashCode;
  }
}
