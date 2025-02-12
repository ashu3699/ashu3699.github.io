import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

import 'pages/login_page.dart';

class AcharyaPlacementCellApp extends StatelessWidget {
  const AcharyaPlacementCellApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Acharya Placement Cell',
        home: AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(body: const LoginPage());
  }
}
