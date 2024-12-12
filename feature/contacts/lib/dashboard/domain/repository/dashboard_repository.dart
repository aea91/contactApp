import 'package:contacts/dashboard/data/model/upload_image_model.dart';
import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:core/typedef/network_typedef.dart';

abstract class DashboardRepository {
  ResultFuture<UserListResponseSuccessDto> fetchUsers({required int skip, required int take});
  ResultFuture<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take});
  ResultFuture<UserDtoModel> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
  });
  ResultFuture<UserDtoModel> fetchSingleUser({required String userId});
  ResultFuture<UserDtoModel> updateSingleUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
    required String userId,
  });
  ResultFuture<void> deleteSingleUser({required String id});
  ResultFuture<UploadImageModel> uploadImage({required List<int> image});
}
