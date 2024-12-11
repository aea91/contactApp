import 'package:contacts/dashboard/presentation/view/contact_dashboard_view.dart';
import 'package:contacts/utils/navigation_constants.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> contactGoRouter = [
  GoRoute(
    path: NavigationConstants.contact_dashboard,
    builder: (context, state) => const ContactDashboardView(),
  ),
];
