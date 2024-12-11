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
    required this.newUser,
    required this.keyword,
  });

  final DashboardStatus status;
  final AppException? exception;
  final List<UserDtoEntity>? userList;
  final String? image;
  final UserEntity? newUser;
  final String? keyword;

  factory DashboardState.initial() => const DashboardState(
        status: DashboardStatus.initial,
        exception: null,
        userList: null,
        image: null,
        newUser: null,
        keyword: null,
      );

  @override
  List<Object?> get props => [status, exception, userList, image, newUser, keyword];

  DashboardState copyWith({
    DashboardStatus? status,
    AppException? exception,
    List<UserDtoEntity>? userList,
    String? image,
    UserEntity? newUser,
    String? keyword,
  }) {
    return DashboardState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      userList: userList ?? this.userList,
      image: image ?? this.image,
      newUser: newUser ?? this.newUser,
      keyword: keyword ?? this.keyword,
    );
  }
}
