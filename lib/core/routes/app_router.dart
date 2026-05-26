import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../init_dependencies.dart';
import '../services/shared_preferences/shared_preferences_service.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}

class AppRouter {
  late final GoRouter config;

  AppRouter() {
    final prefs = serviceLocator<SharedPreferencesService>();

    config = GoRouter(
      initialLocation: prefs.isLoggedIn ? AppRoutes.home : AppRoutes.login,
      routes: [
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.register,
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }
}
