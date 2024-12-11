import 'package:contacts/dashboard/presentation/view/contact_dashboard_view.dart';
import 'package:go_router/go_router.dart';
import 'package:welcome/splash/presentation/splash_view.dart';
import 'package:welcome/utils/navigation_constants.dart';

List<GoRoute> welcoeGoRouter = [
  GoRoute(
    path: NavigationConstants.splash,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    path: NavigationConstants.contact_dashboard,
    builder: (context, state) => const ContactDashboardView(),
  ),
];
