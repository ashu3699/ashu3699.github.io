import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controllers/project.controller.dart';

import '../ui/apps/apps.dart';
import '../ui/pages/pages.dart';
import 'routes.dart';

final mainRouter = GoRouter(
  initialLocation: MainRoutes.home.path,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => BaseScaffold(child: child),
      routes: [
        GoRoute(
          path: MainRoutes.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: MainRoutes.about.path,
          builder: (context, state) => const AboutPage(),
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
              path: 'home',
              builder: (context, state) => const ProjectsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

final mobileRouter = GoRouter(
  initialLocation: ProjectRoutes.home.path,
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MobileScaffold(child: child),
      routes: [
        GoRoute(
          path: MainRoutes.projects.path,
          builder: (context, state) => const MobileHomePage(),
          routes: [
            GoRoute(
              path: 'home',
              builder: (context, state) => const MobileHomePage(),
            ),
            ...ProjectRoutes.values.map(
              (route) => GoRoute(
                path: route.toString().split('.').last,
                builder: (context, state) {
                  final ProjectController projectController =
                      context.read<ProjectController>();
                  final project = projectController.apps.firstWhere(
                    (project) => project.route == route.path,
                  );

                  return project.appWidget;
                },
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const MobileHomePage(),
        ),
        ...ProjectRoutes.values.map(
          (route) => GoRoute(
            path: '/${route.toString().split('.').last}',
            builder: (context, state) {
              final ProjectController projectController =
                  context.read<ProjectController>();
              final project = projectController.apps.firstWhere(
                (project) => project.route == route.path,
              );

              return project.appWidget;
            },
          ),
        ),
        GoRoute(
          path: ProjectRoutes.home.path,
          builder: (context, state) => const MobileHomePage(),
        ),
        ...ProjectRoutes.values.map(
          (route) => GoRoute(
            path: route.path,
            builder: (context, state) {
              final ProjectController projectController =
                  context.read<ProjectController>();
              final project = projectController.apps.firstWhere(
                (project) => project.route == route.path,
              );

              return project.appWidget;
            },
          ),
        ),
      ],
    ),
  ],
);

class BaseScaffold extends StatelessWidget {
  final Widget child;

  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text('My Portfolio'),
        actions: [
          TextButton(
            onPressed: () => context.go(MainRoutes.home.path),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.about.path),
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.experience.path),
            child:
                const Text('Experience', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.projects.path),
            child:
                const Text('Projects', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => context.go(MainRoutes.contact.path),
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: child,
    );
  }
}

class MobileScaffold extends StatelessWidget {
  final Widget child;

  const MobileScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios),
            label: 'Back',
          ),
        ],
        onTap: (index) {
          var projectController = context.read<ProjectController>();
          if (index == 0) {
            projectController.deselectProject();
            context.go(ProjectRoutes.home.path);
          } else {
            if (context.canPop()) {
              context.pop();
            }
            var name = ModalRoute.settingsOf(context)?.name;
            if (name == null) {
              projectController.deselectProject();
            }
          }
        },
      ),
      body: child,
    );
  }
}
