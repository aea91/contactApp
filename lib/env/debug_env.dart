import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'debug_env.g.dart';

@Envied(name: 'Env', path: '.env')
class DebugEnv implements AppEnv, AppEnvFields {
  DebugEnv();

  @override
  @EnviedField(varName: 'BASEURL')
  final String baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'TOKEN')
  final String token = _Env.token;
}
