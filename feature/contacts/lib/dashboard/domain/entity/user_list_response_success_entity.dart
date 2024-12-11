import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';

class UserListResponseSuccessEntity {
  UserListResponseSuccessEntity({required this.users});

  final List<UserDtoEntity> users;

  UserListResponseSuccessEntity copyWith({
    List<UserDtoEntity>? users,
  }) {
    return UserListResponseSuccessEntity(
      users: users ?? this.users,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserListResponseSuccessEntity && other.users == users;
  }

  @override
  int get hashCode => users.hashCode;
}
