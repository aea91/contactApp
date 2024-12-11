import 'package:core/cache/constants/cache_keys.dart';
import 'package:core/cache/shared/shared_manager.dart';
import 'package:core/navigation/go_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome/splash/application/splash_state.dart';
import 'package:welcome/utils/navigation_constants.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  Future<void> init() async {
    print("SplashCubit init");

    if (_checkToken()) {
      // User is logged in
    } else {
      // User is not logged in
    }

    await Future.delayed(const Duration(seconds: 2));

    GoManager.instance.replace(path: NavigationConstants.contact_dashboard);
  }

  bool _checkToken() {
    String? token = SharedManager.instance!.getStringValue(CacheKeys.token.name);
    return token != null;
  }
}
