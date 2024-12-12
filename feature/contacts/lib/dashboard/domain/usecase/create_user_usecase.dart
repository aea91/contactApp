import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';

class CreateUserUsecase extends UseCaseWithParams<UserDtoEntity, CreateUserUsecaseParams> {
  CreateUserUsecase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UserDtoModel> call(CreateUserUsecaseParams params) => _repository.createUser(
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
      profileImageUrl: params.profileImageUrl);
}

class CreateUserUsecaseParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? profileImageUrl;

  CreateUserUsecaseParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  CreateUserUsecaseParams.empty()
      : this(
          firstName: "",
          lastName: "",
          phoneNumber: "",
          profileImageUrl: null,
        );
}
