import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/domain/entity/user_list_response_success_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_users_usecase.g.dart';

class SearchUsersUsecase
    extends UseCaseWithParams<UserListResponseSuccessEntity, SearchUsersUsecaseParams> {
  SearchUsersUsecase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UserListResponseSuccessDto> call(SearchUsersUsecaseParams params) async =>
      _repository.searchUsers(search: params.search, skip: params.skip, take: params.take);
}

@JsonSerializable(createFactory: false)
class SearchUsersUsecaseParams {
  SearchUsersUsecaseParams({required this.search, required this.skip, required this.take});

  final String search;
  final int skip;
  final int take;

  Map<String, dynamic> toJson() => _$SearchUsersUsecaseParamsToJson(this);

  SearchUsersUsecaseParams.empty() : this(search: "", skip: 0, take: 0);
}
