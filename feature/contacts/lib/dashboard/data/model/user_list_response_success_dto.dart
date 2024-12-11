import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/domain/entity/user_list_response_success_entity.dart';

class UserListResponseSuccessDto extends UserListResponseSuccessEntity {
  UserListResponseSuccessDto({required super.users});

  UserListResponseSuccessEntity toEntity() => UserListResponseSuccessEntity(users: users);

  factory UserListResponseSuccessDto.fromJson(Map<String, dynamic> json) {
    return UserListResponseSuccessDto(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserDtoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((e) => (e as UserDtoModel).toJson()).toList(),
    };
  }
}
