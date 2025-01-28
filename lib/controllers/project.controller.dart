import 'package:flutter/foundation.dart';

import '../models/project.model.dart';
import '../routes/routes.dart';
import '../ui/apps/apps.dart';

class ProjectController extends ChangeNotifier {
  static final List<Project> apps = [
    Project(
      title: 'Calculator',
      description:
          'A basic calculator app that supports addition, subtraction, multiplication, and division.',
      imageUrl: 'assets/calculator.png',
      appWidget: () => const CalculatorApp(),
      route: ProjectRoutes.calculator.path,
    ),
    Project(
      title: 'Asteroids',
      description: 'A simple game where you shoot asteroids to earn points.',
      imageUrl: 'assets/asteroids.png',
      appWidget: () => const AsteroidsApp(),
      route: ProjectRoutes.asteroids.path,
    ),

    //Weather
  ];

  Project? selectedProject;

  void selectProject(Project project) {
    selectedProject = project;
    notifyListeners();
  }

  void deselectProject() {
    selectedProject = null;
    notifyListeners();
  }
}
