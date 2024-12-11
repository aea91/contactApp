import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_single_user_usecase.g.dart';

class FetchSingleUserUsecase extends UseCaseWithParams<UserDtoModel, FetchSingleUserUsecaseParams> {
  FetchSingleUserUsecase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<UserDtoModel> call(FetchSingleUserUsecaseParams params) async =>
      _repository.fetchSingleUser(userId: params.userId);
}

@JsonSerializable(createToJson: false)
class FetchSingleUserUsecaseParams {
  final String userId;

  FetchSingleUserUsecaseParams({required this.userId});

  factory FetchSingleUserUsecaseParams.fromJson(Map<String, dynamic> json) =>
      _$FetchSingleUserUsecaseParamsFromJson(json);
}
