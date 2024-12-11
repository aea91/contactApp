import 'package:core/navigation/i_go_service.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class GoManager implements IGoService {
  static final GoManager _instance = GoManager._init();
  static GoManager get instance => _instance;
  GoManager._init();

  late GoRouter _router;

  @override
  init(GoRouter router) {
    _router = router;
  }

  @override
  go({
    required String path,
    Map<String, String>? queryParameters,
    Object? data,
  }) {
    _router.go(
      Uri(path: path, queryParameters: queryParameters).toString(),
      extra: data,
    );
  }

  @override
  Future push({
    required String path,
    Map<String, String>? queryParameters,
    Object? data,
  }) async {
    await _router.push(
      Uri(path: path, queryParameters: queryParameters).toString(),
      extra: data,
    );
  }

  @override
  replace({
    required String path,
    Map<String, String>? queryParameters,
    Object? data,
  }) {
    _router.replace(
      Uri(path: path, queryParameters: queryParameters).toString(),
      extra: data,
    );
  }

  @override
  bool canPop() {
    return _router.canPop();
  }

  @override
  dynamic pop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      return _router.pop<T>(result);
    }
    return null;
  }

  @override
  dispose() {
    _router.dispose();
  }

  @override
  BuildContext? get getContext => _router.routerDelegate.navigatorKey.currentContext;

  void clearAllRoutes({required String newPath}) {
    while (_router.canPop()) {
      _router.pop();
    }
    _router.go(newPath);
  }
}
