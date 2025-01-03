import 'dart:async';
import 'dart:io';

import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/application/dashboard_status.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';
import 'package:contacts/dashboard/domain/usecase/create_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/delete_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/search_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/update_single_user.dart';
import 'package:contacts/dashboard/domain/usecase/upload_user_image.dart';
import 'package:contacts/utils/image_source.dart';
import 'package:contacts/utils/navigation_constants.dart';
import 'package:core/exception/app_exception.dart';
import 'package:core/exception/exception_type.dart';
import 'package:core/logger/contact_logger.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global/application/global_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:packages/image_picker/image_picker_manager.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required FetchUsersUsecase fetchUsersUsecase,
    required CreateUserUsecase createUser,
    required FetchSingleUserUsecase fetchSingleUserUsecase,
    required UpdateSingleUserUsecase updateSingleUserUsecase,
    required DeleteSingleUserUsecase deleteSingleUserUsecase,
    required SearchUsersUsecase searchUserUsecase,
    required UploadUserImageUseCase uploadUserImageUseCase,
  })  : _fetchUsersUsecase = fetchUsersUsecase,
        _createUser = createUser,
        _fetchSingleUserUsecase = fetchSingleUserUsecase,
        _updateSingleUserUsecase = updateSingleUserUsecase,
        _deleteSingleUserUsecase = deleteSingleUserUsecase,
        _searchUsersUsecase = searchUserUsecase,
        _uploadUserImageUseCase = uploadUserImageUseCase,
        super(DashboardState.initial());

  final FetchUsersUsecase _fetchUsersUsecase;
  final CreateUserUsecase _createUser;
  final FetchSingleUserUsecase _fetchSingleUserUsecase;
  final UpdateSingleUserUsecase _updateSingleUserUsecase;
  final DeleteSingleUserUsecase _deleteSingleUserUsecase;
  final SearchUsersUsecase _searchUsersUsecase;
  final UploadUserImageUseCase _uploadUserImageUseCase;
  GlobalCubit? _globalCubit;
  static const _pageSize = 10;
  Timer? _debounce;
  final PagingController<int, UserDtoEntity> pagingController = PagingController(firstPageKey: 0);

  Future<void> initDashboard({required GlobalCubit globalCubit}) async {
    _globalCubit = globalCubit;
    await fetchUsers(pageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      fetchUsers(pageKey: pageKey);
    });
  }

  void initEditUser({required UserDtoEntity selectedUser, required GlobalCubit globalCubit}) {
    _globalCubit = globalCubit;
    emit(state.copyWith(selectedUser: selectedUser));
  }

  void initNewContact({required GlobalCubit globalCubit}) {
    _globalCubit = globalCubit;
  }

  void initContactProfile({required GlobalCubit globalCubit}) {
    _globalCubit = globalCubit;
  }

  Future<void> fetchUsers({required int pageKey}) async {
    bool? isLastPage;
    ContactLogger.instance!.info("TAG", "fetchUsers");
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _fetchUsersUsecase(
        FetchUsersUsecaseParams(skip: pageKey * _pageSize, take: _pageSize));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (users) {
      final List<UserDtoEntity> userList = users.users;
      _globalCubit!.setContactList(userList);
      emit(state.copyWith(userList: userList, status: DashboardStatus.loaded));
      isLastPage = userList.length < _pageSize;
    });
    if (isLastPage ?? false) {
      pagingController.appendLastPage(state.userList as List<UserDtoEntity>);
    } else {
      final nextPage = pageKey + 1;
      pagingController.appendPage(state.userList as List<UserDtoEntity>, nextPage);
    }
  }

  Future<void> searchUsers({required String search, required int pageKey}) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(seconds: 1), () async {
      bool? isLastPage;

      if (pageKey == 0) {
        pagingController.itemList = [];
      }
      emit(state.copyWith(status: DashboardStatus.loading));
      final result = await _searchUsersUsecase(
          SearchUsersUsecaseParams(search: search, skip: pageKey, take: _pageSize));
      result.fold((failure) {
        emit(state.copyWith(status: DashboardStatus.error, exception: failure));
      }, (users) {
        final List<UserDtoEntity> userList = users.users;
        emit(state.copyWith(userList: userList, status: DashboardStatus.loaded));
        _globalCubit!.setContactList(userList);
        isLastPage = userList.length < _pageSize;
      });
      if (isLastPage ?? false) {
        pagingController.appendLastPage(state.userList as List<UserDtoEntity>);
      } else {
        final nextPage = pageKey + 1;
        pagingController.appendPage(state.userList as List<UserDtoEntity>, nextPage);
      }
    });
  }

  Future<void> createUser({required UserEntity user}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _createUser(CreateUserUsecaseParams(
        firstName: user.firstName!,
        lastName: user.lastName!,
        phoneNumber: user.phoneNumber!,
        profileImageUrl: user.profileImageUrl));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {
      final List<UserDtoEntity> updatedList = [...state.userList ?? []];
      updatedList.add(user);
      _globalCubit!.setContactList(updatedList);
      _globalCubit!.setException(
        const AppException(
          message: "User added !",
          type: ExceptionType.info,
          showMessage: true,
        ),
      );
      emit(state.copyWith(
        userList: updatedList,
        status: DashboardStatus.loaded,
      ));
    });
  }

  Future<void> fetchSingleUser({required String userId}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _fetchSingleUserUsecase(FetchSingleUserUsecaseParams(userId: userId));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {});
  }

  Future<void> updateSingleUser({required UserEntity user, required String userId}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _updateSingleUserUsecase(UpdateSingleUserUsecaseParams(
        firstName: user.firstName!,
        lastName: user.lastName!,
        phoneNumber: user.phoneNumber!,
        profileImageUrl: user.profileImageUrl,
        userId: userId));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) async {
      final List<UserDtoEntity> updatedList = [...state.userList ?? []];
      updatedList.removeWhere((user) => user.id == userId);
      updatedList.add(user);
      _globalCubit!.setContactList(updatedList);
      emit(state.copyWith(status: DashboardStatus.loaded, userList: updatedList));
      _globalCubit!.setException(
        const AppException(
          message: "Changes have been applied!",
          type: ExceptionType.info,
          showMessage: true,
        ),
      );

      GoManager.instance.pop(true);
      GoManager.instance.pop(true);
      _globalCubit!.setIsRefresh(true);
    });
  }

  Future<void> deleteSingleUser({required String id}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _deleteSingleUserUsecase(DeleteSingleUserUsecaseParams(id: id));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) async {
      // Remove deleted user from current list
      final List<UserDtoEntity> updatedList = [...state.userList ?? []];
      updatedList.removeWhere((user) => user.id == id);
      _globalCubit!.setContactList(updatedList);
      _globalCubit!.setException(
        const AppException(
          message: "Account deleted!",
          type: ExceptionType.info,
          showMessage: true,
        ),
      );
      emit(state.copyWith(status: DashboardStatus.loaded, userList: updatedList));

      GoManager.instance.pop();
      GoManager.instance.pop();
      _globalCubit!.setIsRefresh(true);
    });
  }

  Future<void> handleImageSelect({required ImageSource imageSource}) async {
    String? path;
    if (imageSource == ImageSource.camera) {
      path = await ImagePickerManager.instance!.pickImageCamera();
    } else {
      path = await ImagePickerManager.instance!.pickImageGallery();
    }
    if (path != null) {
      emit(state.copyWith(image: path));
    }

    GoManager.instance.pop();
  }

  Future<void> handleUpdateUser() async {
    UserDtoEntity? selectedUser = state.selectedUser;
    if (selectedUser == null) {
      _globalCubit!.setException(
        const AppException(
          message: "Please select a user",
          type: ExceptionType.info,
          showMessage: true,
        ),
      );
      return;
    }

    if (state.image != null) {
      List<int> imageInt = await File(state.image!).readAsBytes();
      String? imageUrl = await uploadUserImage(image: imageInt);
      selectedUser = selectedUser.copyWith(profileImageUrl: imageUrl);
    }
    await updateSingleUser(user: selectedUser, userId: selectedUser.id!);
  }

  Future<void> handleCreateUser({required BuildContext context}) async {
    UserEntity? newUser = state.user;
    String? imagePath = state.image;

    if (newUser == null) {
      _globalCubit!.setException(
        const AppException(
          message: "Please fill all fields",
          type: ExceptionType.info,
          showMessage: true,
        ),
      );

      GoManager.instance.pop();
      return;
    }

    if (imagePath != null) {
      List<int> imageInt = await File(imagePath).readAsBytes();
      String? imageUrl = await uploadUserImage(image: imageInt);
      newUser = newUser.copyWith(profileImageUrl: imageUrl);
    }

    await createUser(user: newUser);
  }

  Future<String?> uploadUserImage({required List<int> image}) async {
    final result = await _uploadUserImageUseCase(UploadUserImageParams(image: image));
    return result.fold(
      (failure) {
        emit(state.copyWith(status: DashboardStatus.error, exception: failure));
        return null;
      },
      (imageResponse) => imageResponse.imageUrl,
    );
  }

  void setFirstName({required String firstName}) {
    print("setFirstName: $firstName");
    UserEntity? user = state.user;
    user ??=
        UserEntity(firstName: firstName, lastName: null, phoneNumber: null, profileImageUrl: null);
    user = user.copyWith(firstName: firstName);
    emit(state.copyWith(user: user));
  }

  void setLastName({required String lastName}) {
    print("setLastName: $lastName");
    UserEntity? user = state.user;
    user ??=
        UserEntity(firstName: null, lastName: null, phoneNumber: lastName, profileImageUrl: null);
    user = user.copyWith(lastName: lastName);
    emit(state.copyWith(user: user));
  }

  void setPhoneNumber({required String phoneNumber}) {
    print("setPhoneNumber: $phoneNumber");
    UserEntity? user = state.user;
    user ??= UserEntity(
        firstName: null, lastName: null, phoneNumber: phoneNumber, profileImageUrl: null);
    user = user.copyWith(phoneNumber: phoneNumber);
    emit(state.copyWith(user: user));
  }

  void setSelectedUser({required UserDtoEntity user}) {
    emit(state.copyWith(selectedUser: user));
  }

  void editFirstName({required String firstName}) {
    emit(state.copyWith(selectedUser: state.selectedUser?.copyWith(firstName: firstName)));
  }

  void editLastName({required String lastName}) {
    emit(state.copyWith(selectedUser: state.selectedUser?.copyWith(lastName: lastName)));
  }

  void editPhoneNumber({required String phoneNumber}) {
    emit(state.copyWith(selectedUser: state.selectedUser?.copyWith(phoneNumber: phoneNumber)));
  }

  bool isAllFieldsFilled() {
    return state.user?.firstName != null &&
        state.user!.firstName!.trim().isNotEmpty &&
        state.user?.lastName != null &&
        state.user!.lastName!.trim().isNotEmpty &&
        state.user?.phoneNumber != null &&
        state.user!.phoneNumber!.trim().isNotEmpty;
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
