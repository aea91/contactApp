import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';

abstract class DashboardRemoteDatasource {
  Future<UserListResponseSuccessDto> fetchUsers({required int skip, required int take});
  Future<UserDtoModel> createUser({required UserModel user});
  Future<UserDtoModel> fetchSingleUser({required String userId});
  Future<UserDtoModel> updateSingleUser({required UserEntity user, required String userId});
  Future<void> deleteSingleUser({required String userId});
  Future<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take});
}
