import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/domain/entity/user_list_response_success_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_users_usecase.g.dart';

class FetchUsersUsecase
    extends UseCaseWithParams<UserListResponseSuccessEntity, FetchUsersUsecaseParams> {
  FetchUsersUsecase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UserListResponseSuccessDto> call(FetchUsersUsecaseParams params) async =>
      _repository.fetchUsers(skip: params.skip, take: params.take);
}

@JsonSerializable(createFactory: false)
class FetchUsersUsecaseParams {
  FetchUsersUsecaseParams({required this.skip, required this.take});

  final int skip;
  final int take;

  Map<String, dynamic> toJson() => _$FetchUsersUsecaseParamsToJson(this);

  FetchUsersUsecaseParams.empty() : this(skip: 0, take: 0);
}
