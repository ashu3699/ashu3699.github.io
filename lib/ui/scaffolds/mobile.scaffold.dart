import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/project.controller.dart';
import '../../routes/routes.dart';

class MobileScaffold extends StatelessWidget {
  final Widget child;

  const MobileScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
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
