import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';
import 'package:core/typedef/network_typedef.dart';

abstract class DashboardRepository {
  ResultFuture<UserListResponseSuccessDto> fetchUsers({required int skip, required int take});
  ResultFuture<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take});
  ResultFuture<UserDtoModel> createUser({required UserModel user});
  ResultFuture<UserDtoModel> fetchSingleUser({required String userId});
  ResultFuture<UserDtoModel> updateSingleUser({required UserEntity user, required String userId});
  ResultFuture<void> deleteSingleUser({required String userId});
}
