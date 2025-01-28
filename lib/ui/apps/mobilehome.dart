import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/project.controller.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  final apps = ProjectController.apps;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: apps.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final app = apps[index];
        return GestureDetector(
          onTap: () {
            context.push(app.route);
            setState(() {
              var projectController = context.read<ProjectController>();
              projectController.selectProject(app);
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(app.imageUrl, height: 80),
              const SizedBox(height: 8),
              Text(app.title),
            ],
          ),
        );
      },
    );
  }
}
