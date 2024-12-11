import 'package:welcome/splash/data/datasource/splash_remote_datasource.dart';
import 'package:welcome/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImplementation extends SplashRepository {
  // ignore: unused_field
  final SplashRemoteDatasource _remoteDatasource;

  SplashRepositoryImplementation(this._remoteDatasource);
}
