import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:portfolio/controllers/project.controller.dart';
import 'package:provider/provider.dart';

import 'routes/gorouter.dart';

void main() {
  usePathUrlStrategy();
  runApp(ChangeNotifierProvider(
    create: (context) => ProjectController(),
    child: const MyPortfolioApp(),
  ));
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: mainRouter,
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
