import 'package:contacts/dashboard/application/dashboard_cubit.dart';
import 'package:contacts/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:contacts/dashboard/data/datasource/dashboard_remote_datasource_implementation.dart';
import 'package:contacts/dashboard/data/repository/dashboard_repository_implementation.dart';
import 'package:contacts/dashboard/domain/repository/dashboard_repository.dart';
import 'package:contacts/dashboard/domain/usecase/create_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/delete_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_single_user_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/fetch_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/search_users_usecase.dart';
import 'package:contacts/dashboard/domain/usecase/update_single_user.dart';
import 'package:core/network/network_manager.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> getItContactsInit() async {
  sl
    ..registerFactory(() => DashboardCubit(
          fetchUsersUsecase: sl(),
          createUser: sl(),
          fetchSingleUserUsecase: sl(),
          updateSingleUserUsecase: sl(),
          deleteSingleUserUsecase: sl(),
          searchUserUsecase: sl(),
        ))
    ..registerLazySingleton(() => FetchUsersUsecase(sl()))
    ..registerLazySingleton(() => CreateUserUsecase(sl()))
    ..registerLazySingleton(() => FetchSingleUserUsecase(sl()))
    ..registerLazySingleton(() => UpdateSingleUserUsecase(sl()))
    ..registerLazySingleton(() => DeleteSingleUserUsecase(sl()))
    ..registerLazySingleton(() => SearchUsersUsecase(sl()))
    ..registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImplementation(sl()))
    ..registerLazySingleton<DashboardRemoteDatasource>(
        () => DashboardRemoteDatasourceImplementation(NetworkManager.instance!));
}
