import 'package:device_preview_plus/device_preview_plus.dart';
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
  DeviceInfo selectedDevice = androidDevice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width > 600) {
      return websiteView();
    } else {
      return MobileScreenApp(selectedDevice: selectedDevice);
    }
  }

  Widget websiteView() {
    return Row(
      children: [
        SizedBox(width: 30),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        projectController.selectedProject!.imageUrl,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        projectController.selectedProject!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    projectController.selectedProject!.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: MobileScreenApp(selectedDevice: selectedDevice),
                ),
              ),
              //button to switch ios/android
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (selectedDevice == iosDevice) {
                      selectedDevice = androidDevice;
                    } else {
                      selectedDevice = iosDevice;
                    }
                  });
                },
                child: Text(
                  selectedDevice == iosDevice
                      ? 'Switch to Android'
                      : 'Switch to iOS',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileScreenApp extends StatelessWidget {
  const MobileScreenApp({super.key, required this.selectedDevice});

  final DeviceInfo selectedDevice;

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      device: selectedDevice,
      // device: iosDevice,
      screen: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: mobileRouter,
        // theme: ThemeData(primarySwatch: Colors.teal),
      ),
    );
  }
}
