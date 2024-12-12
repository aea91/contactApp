import 'package:contacts/utils/contact_go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:welcome/splash/presentation/splash_view.dart';
import 'package:welcome/utils/welcome_go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    ...welcoeGoRouter,
    ...contactGoRouter,
  ],
);
