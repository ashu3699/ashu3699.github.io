import 'package:go_router/go_router.dart';

import '../ui/apps/apps.dart';
import '../ui/pages/pages.dart';
import '../ui/scaffolds/scaffolds.dart';
import 'routes.dart';

final mainRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          redirect: (context, state) => MainRoutes.home.path,
        ),
        GoRoute(
          path: MainRoutes.home.path,
          builder: (context, state) => const HomePage(),
          redirect: (context, state) => MainRoutes.home.path,
        ),
        GoRoute(
          path: MainRoutes.about.path,
          builder: (context, state) => const AboutPage(),
          redirect: (context, state) => MainRoutes.about.path,
        ),
        GoRoute(
          path: MainRoutes.contact.path,
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          path: MainRoutes.experience.path,
          builder: (context, state) => const ExperiencePage(),
        ),
        GoRoute(
          path: MainRoutes.projects.path,
          builder: (context, state) => const ProjectsPage(),
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const ProjectsPage(),
            ),
            GoRoute(
              path: '/calculator',
              builder: (context, state) => const CalculatorApp(),
            ),
            GoRoute(
              path: '/acharyahabba',
              builder: (context, state) => const AcharyaHabbaApp(),
            ),
            GoRoute(
              path: '/asteroids',
              builder: (context, state) => const AsteroidsApp(),
            ),
          ],
        ),
      ],
    ),
  ],
);

final mobileRouter = GoRouter(
  initialLocation: MainRoutes.projects.path,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MobileScaffold(child: child),
      routes: [
        GoRoute(
          path: MainRoutes.projects.path,
          builder: (context, state) => const MobileHomePage(),
        ),
        GoRoute(
          path: ProjectRoutes.home.path,
          builder: (context, state) => const MobileHomePage(),
        ),
        GoRoute(
          path: ProjectRoutes.calculator.path,
          builder: (context, state) => const CalculatorApp(),
        ),
        GoRoute(
          path: ProjectRoutes.acharyahabba.path,
          builder: (context, state) => const AcharyaHabbaApp(),
        ),
        GoRoute(
          path: ProjectRoutes.asteroids.path,
          builder: (context, state) => const AsteroidsApp(),
        ),
      ],
    ),
  ],
);
