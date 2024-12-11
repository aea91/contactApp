import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';

class UpdateSingleUserUsecase
    extends UseCaseWithParams<UserDtoModel, UpdateSingleUserUsecaseParams> {
  final DashboardRepository _repository;

  UpdateSingleUserUsecase(this._repository);

  @override
  ResultFuture<UserDtoModel> call(UpdateSingleUserUsecaseParams params) async =>
      _repository.updateSingleUser(user: params.user, userId: params.userId);
}

class UpdateSingleUserUsecaseParams {
  final UserEntity user;
  final String userId;

  UpdateSingleUserUsecaseParams({required this.user, required this.userId});

  Map<String, dynamic> toJson() => {'userId': userId};
}
