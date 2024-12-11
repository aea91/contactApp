import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';

class CreateUserUsecase extends UseCaseWithParams<UserDtoModel, CreateUserUsecaseParams> {
  CreateUserUsecase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UserDtoModel> call(CreateUserUsecaseParams params) =>
      _repository.createUser(user: params.user);
}

class CreateUserUsecaseParams {
  final UserModel user;

  CreateUserUsecaseParams({required this.user});
}
