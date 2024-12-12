import 'package:contacts/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:contacts/dashboard/data/model/upload_image_model.dart';
import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
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
  ResultFuture<UserDtoModel> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
  }) async {
    try {
      final response = await _datasource.createUser(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profileImageUrl: profileImageUrl);
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
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
    required String userId,
  }) async {
    try {
      final response = await _datasource.updateSingleUser(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profileImageUrl: profileImageUrl,
          userId: userId);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteSingleUser({required String id}) async {
    try {
      await _datasource.deleteSingleUser(id: id);
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

  @override
  ResultFuture<UploadImageModel> uploadImage({required List<int> image}) async {
    try {
      final response = await _datasource.uploadImage(image: image);
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkException.fromException(e));
    }
  }
}
