import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_response_success_dto.g.dart';

@JsonSerializable()
class UserListResponseSuccessDto {
  UserListResponseSuccessDto({required this.users});

  final List<UserDtoModel> users;

  factory UserListResponseSuccessDto.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseSuccessDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseSuccessDtoToJson(this);
}
