import 'package:bankemployers/core/routing/routes.dart';
import 'package:bankemployers/features/empleyees/view/cv_upload_page.dart';
import 'package:bankemployers/features/empleyees/view/empl_dadhboard.dart';
import 'package:bankemployers/features/splash/splash_view.dart';
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
    ],
  );
}
