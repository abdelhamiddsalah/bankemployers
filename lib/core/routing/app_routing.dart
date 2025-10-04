import 'package:bankemployers/core/routing/routes.dart';
import 'package:bankemployers/features/cvs/view/cv_upload_page.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/empl_dadhboard.dart';
import 'package:bankemployers/features/employers_profile/view/empl_profile_view.dart';
import 'package:bankemployers/features/splash/view/splash_view.dart';
import 'package:bankemployers/features/splash/view/user_role.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splah,
    routes: <GoRoute>[
      GoRoute(path: Routes.splah, builder: (context, state) => SplashScreen()),

      GoRoute(
        path: Routes.employeeDashboard,
        builder: (context, state) => UsersDashboard(),
      ),
      GoRoute(
        path: Routes.uploadCV,
        builder: (context, state) => CVUploadPage(),
      ),
      GoRoute(
        path: Routes.userCoice,
        builder: (context, state) => UserRoleSelectionScreen(),
      ),
      GoRoute(
        path: Routes.employersProfile,
        builder: (context, state) => EmployeeProfileView(),
      ),
    ],
  );
}
