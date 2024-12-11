import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class IGoService {
  init(GoRouter router);
  go({
    required String path,
    Object? data,
  });
  Future push({
    required String path,
    Object? data,
  });
  replace({
    required String path,
    Object? data,
  });
  bool canPop();
  pop<T extends Object?>([T? result]);
  dispose();
  BuildContext? get getContext;
}
