import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:core/usecase/usecase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_single_user_usecase.g.dart';

class DeleteSingleUserUsecase extends UseCaseWithParams<void, DeleteSingleUserUsecaseParams> {
  final DashboardRepository _repository;

  DeleteSingleUserUsecase(this._repository);

  @override
  ResultFuture<void> call(DeleteSingleUserUsecaseParams params) async =>
      _repository.deleteSingleUser(id: params.id);
}

@JsonSerializable(createFactory: false)
class DeleteSingleUserUsecaseParams {
  final String id;

  DeleteSingleUserUsecaseParams({required this.id});

  Map<String, dynamic> toJson() => _$DeleteSingleUserUsecaseParamsToJson(this);

  DeleteSingleUserUsecaseParams.empty() : this(id: "");
}
