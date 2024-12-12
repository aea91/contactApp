import 'package:contacts/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:contacts/dashboard/data/model/upload_image_model.dart';
import 'package:contacts/dashboard/data/model/user_dto_model.dart';
import 'package:contacts/dashboard/data/model/user_list_response_success_dto.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/search_users_usecase.dart';
import 'package:contacts/utils/network_constants.dart';
import 'package:core/base/model/network_error.dart';
import 'package:core/global/global_helper.dart';
import 'package:core/network/interface_network_manager.dart';
import 'package:dio/dio.dart';

class DashboardRemoteDatasourceImplementation extends DashboardRemoteDatasource {
  DashboardRemoteDatasourceImplementation(this._manager);

  final InterfaceNetworkManager _manager;

  @override
  Future<UserListResponseSuccessDto> fetchUsers({required int skip, required int take}) async {
    final response = await _manager.dioGet(
      queryParam: FetchUsersUsecaseParams(skip: skip, take: take).toJson(),
      path: NetworkConstants.user,
      fromJson: UserListResponseSuccessDto.fromJson,
      token: GlobalHelper.getToken(),
    );

    if (response is NetworkException) {
      throw response;
    }

    return response as UserListResponseSuccessDto;
  }

  @override
  Future<UserDtoModel> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
  }) async {
    final response = await _manager.dioPost(
      path: NetworkConstants.user,
      model: UserModel(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profileImageUrl: profileImageUrl),
      fromJson: UserDtoModel.fromJson,
      token: "49fbc414-78fb-4fd4-953d-be210be2a829",
    );

    if (response is NetworkException) {
      throw response;
    }

    return response as UserDtoModel;
  }

  @override
  Future<UserDtoModel> fetchSingleUser({required String userId}) async {
    final response = await _manager.dioGet(
      path: NetworkConstants.user,
      fromJson: UserDtoModel.fromJson,
      token: "49fbc414-78fb-4fd4-953d-be210be2a829",
    );

    if (response is NetworkException) {
      throw response;
    }

    return response as UserDtoModel;
  }

  @override
  Future<UserDtoModel> updateSingleUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String? profileImageUrl,
    required String userId,
  }) async {
    final response = await _manager.dioPut(
      path: NetworkConstants.updateUser(id: userId),
      model: UserModel(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          profileImageUrl: profileImageUrl),
      fromJson: UserDtoModel.fromJson,
      token: GlobalHelper.getToken()!,
    );

    if (response is NetworkException) {
      throw response;
    }

    return response as UserDtoModel;
  }

  @override
  Future<void> deleteSingleUser({required String id}) async {
    final response = await _manager.dioDelete(
      fromJson: null,
      path: NetworkConstants.deleteUser(id: id),
      token: GlobalHelper.getToken()!,
    );

    if (response is NetworkException) {
      throw response;
    }

    return response;
  }

  @override
  Future<UserListResponseSuccessDto> searchUsers(
      {required String search, required int skip, required int take}) async {
    final response = await _manager.dioGet(
      queryParam: SearchUsersUsecaseParams(search: search, skip: skip, take: take).toJson(),
      path: NetworkConstants.user,
      fromJson: UserListResponseSuccessDto.fromJson,
      token: GlobalHelper.getToken(),
    );

    if (response is NetworkException) {
      throw response;
    }

    return response as UserListResponseSuccessDto;
  }

  @override
  Future<UploadImageModel> uploadImage({required List<int> image}) async {
    MultipartFile img = MultipartFile.fromBytes(image, filename: "${DateTime.now()}");

    final data = FormData.fromMap({"image": img});

    final response = await _manager.postForm(
      path: NetworkConstants.uploadImage,
      formData: data,
      token: GlobalHelper.getToken()!,
      fromJson: UploadImageModel.fromJson,
    );

    if (response is NetworkException) {
      throw response;
    }

    return response;
  }
}
