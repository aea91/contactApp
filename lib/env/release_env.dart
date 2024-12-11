import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'release_env.g.dart';

@Envied(name: 'Env', path: '.env.prod')
class ReleaseEnv implements AppEnv, AppEnvFields {
  ReleaseEnv();

  @override
  @EnviedField(varName: 'BASEURL')
  final String baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'TOKEN')
  final String token = _Env.token;
}
