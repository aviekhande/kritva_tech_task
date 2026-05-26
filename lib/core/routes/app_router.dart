import 'package:go_router/go_router.dart';
import 'package:kritva_tech_task/features/onboarding/presentation/pages/onboarding_page.dart';

class AppRouter {
  final GoRouter config = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const OnboardingPage()),
    ],
  );
}
