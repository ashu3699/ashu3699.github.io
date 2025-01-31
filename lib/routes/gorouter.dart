import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/apps/apps.dart';
import '../ui/pages/pages.dart';
import '../ui/scaffolds/scaffolds.dart';
import 'routes.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final mainRouter = GoRouter(
  navigatorKey: _parentKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => BaseScaffold(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellKey,
          name: 'home',
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        // GoRoute(
        //   parentNavigatorKey: _shellKey,
        //   name: 'home',
        //   path: MainRoutes.home.path,
        //   builder: (context, state) => const HomePage(),
        // ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          name: 'about',
          path: MainRoutes.about.path,
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          name: 'contact',
          path: MainRoutes.contact.path,
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          name: 'experience',
          path: MainRoutes.experience.path,
          builder: (context, state) => const ExperiencePage(),
        ),
        GoRoute(
          parentNavigatorKey: _shellKey,
          name: 'projects',
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
