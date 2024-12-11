import 'package:contacts/dashboard/application/dashboard_status.dart';
import 'package:contacts/dashboard/domain/entity/user_dto_entity.dart';
import 'package:contacts/dashboard/domain/entity/user_entity.dart';
import 'package:core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.status,
    required this.exception,
    required this.userList,
    required this.image,
    required this.user,
    required this.selectedUser,
    required this.keyword,
    required this.message,
  });

  final DashboardStatus status;
  final AppException? exception;
  final List<UserDtoEntity>? userList;
  final String? image;
  final UserEntity? user;
  final UserDtoEntity? selectedUser;
  final String? keyword;
  final String? message;

  factory DashboardState.initial() => const DashboardState(
        status: DashboardStatus.initial,
        exception: null,
        userList: null,
        image: null,
        user: null,
        selectedUser: null,
        keyword: null,
        message: null,
      );

  @override
  List<Object?> get props =>
      [status, exception, userList, image, user, selectedUser, keyword, message];

  DashboardState copyWith({
    DashboardStatus? status,
    AppException? exception,
    List<UserDtoEntity>? userList,
    String? image,
    UserEntity? user,
    UserDtoEntity? selectedUser,
    String? keyword,
    String? message,
  }) {
    return DashboardState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      userList: userList ?? this.userList,
      image: image ?? this.image,
      user: user ?? this.user,
      selectedUser: selectedUser ?? this.selectedUser,
      keyword: keyword ?? this.keyword,
      message: message ?? this.message,
    );
  }
}
