import 'package:contacts/dashboard/data/model/upload_image_model.dart';
import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';

abstract class DashboardRemoteDatasource {
  Future<UserListResponseSuccessDto> fetchUsers({required int skip, required int take});
  Future<UserDtoModel> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
  });
  Future<UserDtoModel> fetchSingleUser({required String userId});
  Future<UserDtoModel> updateSingleUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String profileImageUrl,
  });
  Future<void> deleteSingleUser({required String userId});
  Future<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take});
  Future<UploadImageModel> uploadImage({required List<int> image});
}
