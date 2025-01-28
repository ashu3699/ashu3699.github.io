import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/project.controller.dart';

import '../../routes/gorouter.dart';
import '../frames/frames.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<ProjectController>(
              builder: (context, projectController, child) {
            if (projectController.selectedProject == null) {
              return const Center(
                child: Text(
                  'Select a project to view details',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blueGrey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectController.selectedProject!.title,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Image.asset(
                  //   _selectedProject!.imageUrl,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  // ),
                  const SizedBox(height: 16),
                  Text(
                    projectController.selectedProject!.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: MobileScreenApp(),
          ),
        ),
      ],
    );
  }
}

class MobileScreenApp extends StatelessWidget {
  const MobileScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      device: androidDevice,
      // device: iosDevice,
      screen: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: mobileRouter,
        // theme: ThemeData(primarySwatch: Colors.teal),
      ),
    );
  }
}
