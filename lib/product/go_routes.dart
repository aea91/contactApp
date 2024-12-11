import 'package:contacts/utils/contact_go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:welcome/splash/presentation/splash_view.dart';
import 'package:welcome/utils/welcome_go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    ...welcoeGoRouter,
    ...contactGoRouter,
  ],
);
