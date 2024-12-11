import 'package:core/network/network_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:welcome/splash/application/splash_cubit.dart';
import 'package:welcome/splash/data/datasource/splash_remote_datasource.dart';
import 'package:welcome/splash/data/datasource/splash_remote_datasource_implementation.dart';
import 'package:welcome/splash/data/repository/splash_repository_implementation.dart';
import 'package:welcome/splash/domain/repository/splash_repository.dart';

final sl = GetIt.instance;

Future<void> getItWelcomeInit() async {
  sl
    ..registerFactory(() => SplashCubit())
    ..registerLazySingleton<SplashRepository>(() => SplashRepositoryImplementation(sl()))
    ..registerLazySingleton<SplashRemoteDatasource>(
        () => SplashRemoteDatasourceImplementation(NetworkManager.instance!));
}
