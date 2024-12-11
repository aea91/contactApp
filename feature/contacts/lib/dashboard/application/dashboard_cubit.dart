import 'package:contacts/dashboard/application/dashboard_state.dart';
import 'package:contacts/dashboard/application/dashboard_status.dart';
import 'package:contacts/dashboard/data/model/user_model.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/domain/usecase/create_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/delete_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/search_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/update_single_user.dart';
import 'package:contacts/utils/image_source.dart';
import 'package:core/logger/contact_logger.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:packages/image_picker/image_picker_manager.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
      {required FetchUsersUsecase fetchUsersUsecase,
      required CreateUserUsecase createUser,
      required FetchSingleUserUsecase fetchSingleUserUsecase,
      required UpdateSingleUserUsecase updateSingleUserUsecase,
      required DeleteSingleUserUsecase deleteSingleUserUsecase,
      required SearchUsersUsecase searchUserUsecase})
      : _fetchUsersUsecase = fetchUsersUsecase,
        _createUser = createUser,
        _fetchSingleUserUsecase = fetchSingleUserUsecase,
        _updateSingleUserUsecase = updateSingleUserUsecase,
        _deleteSingleUserUsecase = deleteSingleUserUsecase,
        _searchUsersUsecase = searchUserUsecase,
        super(DashboardState.initial());

  final FetchUsersUsecase _fetchUsersUsecase;
  final CreateUserUsecase _createUser;
  final FetchSingleUserUsecase _fetchSingleUserUsecase;
  final UpdateSingleUserUsecase _updateSingleUserUsecase;
  final DeleteSingleUserUsecase _deleteSingleUserUsecase;
  final SearchUsersUsecase _searchUsersUsecase;
  static const _pageSize = 10;
  final PagingController<int, UserDtoEntity> pagingController = PagingController(firstPageKey: 0);

  Future<void> init() async {
    await fetchUsers(pageKey: 0);
    pagingController.addPageRequestListener((pageKey) {});
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
      emit(state.copyWith(userList: users.users, status: DashboardStatus.loaded));
      isLastPage = users.users.length < _pageSize;
    });
    if (isLastPage ?? false) {
      pagingController.appendLastPage(state.userList ?? []);
    } else {
      final nextPage = pageKey + 1;
      pagingController.appendPage(state.userList ?? [], nextPage);
    }
  }

  Future<void> searchUsers({required String search, required int pageKey}) async {
    bool? isLastPage;
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _searchUsersUsecase(
        SearchUsersUsecaseParams(search: search, skip: pageKey, take: _pageSize));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (users) {
      emit(state.copyWith(userList: users.users, status: DashboardStatus.loaded));
      isLastPage = users.users.length < _pageSize;
    });
    if (isLastPage ?? false) {
      pagingController.appendLastPage(state.userList ?? []);
    } else {
      final nextPage = pageKey + 1;
      pagingController.appendPage(state.userList ?? [], nextPage);
    }
  }

  Future<void> createUser({required UserModel user}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _createUser(CreateUserUsecaseParams(user: user));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {
      emit(state.copyWith(status: DashboardStatus.loaded));
    });
  }

  Future<void> fetchSingleUser({required String userId}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _fetchSingleUserUsecase(FetchSingleUserUsecaseParams(userId: userId));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {});
  }

  Future<void> updateSingleUser({required UserModel user, required String userId}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result =
        await _updateSingleUserUsecase(UpdateSingleUserUsecaseParams(user: user, userId: userId));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {
      emit(state.copyWith(status: DashboardStatus.loaded));
    });
  }

  Future<void> deleteSingleUser({required String userId}) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _deleteSingleUserUsecase(DeleteSingleUserUsecaseParams(userId: userId));
    result.fold((failure) {
      emit(state.copyWith(status: DashboardStatus.error, exception: failure));
    }, (user) {
      emit(state.copyWith(status: DashboardStatus.loaded));
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

  void setFirstName({required String firstName}) {
    emit(state.copyWith(newUser: state.newUser?.copyWith(firstName: firstName)));
  }

  void setLastName({required String lastName}) {
    emit(state.copyWith(newUser: state.newUser?.copyWith(lastName: lastName)));
  }

  void setPhoneNumber({required String phoneNumber}) {
    emit(state.copyWith(newUser: state.newUser?.copyWith(phoneNumber: phoneNumber)));
  }

  bool isAllFieldsFilled() {
    return state.newUser?.firstName != null &&
        state.newUser!.firstName!.trim().isNotEmpty &&
        state.newUser?.lastName != null &&
        state.newUser!.lastName!.trim().isNotEmpty &&
        state.newUser?.phoneNumber != null &&
        state.newUser!.phoneNumber!.trim().isNotEmpty;
  }
}
