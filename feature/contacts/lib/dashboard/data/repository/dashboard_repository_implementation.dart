import 'package:contacts/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:core/base/model/network_error.dart';
import 'package:core/typedef/network_typedef.dart';
import 'package:fpdart/fpdart.dart';

class DashboardRepositoryImplementation implements DashboardRepository {
  DashboardRepositoryImplementation(this._datasource);

  final DashboardRemoteDatasource _datasource;

  @override
  ResultFuture<UserListResponseSuccessDto> fetchUsers(
      {required int skip, required int take}) async {
    try {
      final response = await _datasource.fetchUsers(skip: skip, take: take);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<UserDtoModel> createUser({required UserModel user}) async {
    try {
      final response = await _datasource.createUser(user: user);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<UserDtoModel> fetchSingleUser({required String userId}) async {
    try {
      final response = await _datasource.fetchSingleUser(userId: userId);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<UserDtoModel> updateSingleUser({
    required UserEntity user,
    required String userId,
  }) async {
    try {
      final response = await _datasource.updateSingleUser(user: user, userId: userId);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteSingleUser({required String userId}) async {
    try {
      await _datasource.deleteSingleUser(userId: userId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take}) async {
    try {
      final response = await _datasource.searchUsers(search: search, skip: skip, take: take);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }
}
