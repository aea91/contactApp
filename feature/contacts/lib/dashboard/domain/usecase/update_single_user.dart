import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_single_user.g.dart';

class UpdateSingleUserUsecase
    extends UseCaseWithParams<UserDtoEntity, UpdateSingleUserUsecaseParams> {
  final DashboardRepository _repository;

  UpdateSingleUserUsecase(this._repository);

  @override
  ResultFuture<UserDtoModel> call(UpdateSingleUserUsecaseParams params) async =>
      _repository.updateSingleUser(
          firstName: params.firstName,
          lastName: params.lastName,
          phoneNumber: params.phoneNumber,
          profileImageUrl: params.profileImageUrl,
          userId: params.userId);
}

@JsonSerializable(createFactory: false)
class UpdateSingleUserUsecaseParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImageUrl;
  final String userId;

  UpdateSingleUserUsecaseParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.userId,
  });

  Map<String, dynamic> toJson() => _$UpdateSingleUserUsecaseParamsToJson(this);
}
