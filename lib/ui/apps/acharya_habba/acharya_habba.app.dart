// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

// import 'package:acharya_habba/pages/splash_screen.dart';
// import 'package:acharya_habba/pages/verify_email.dart';

// import 'firebase_options.dart';
// import 'models/push_notification.dart';
import 'pages/sign_in.dart';
import 'pages/splash_screen.dart';
import 'provider/navigation_provider.dart';
import 'services/navigator.dart';

class AcharyaHabbaApp extends StatelessWidget {
  const AcharyaHabbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const SplashScreen(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const SignInPage(),
        // body: StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return const Center(child: Text('Something went wrong!'));
        //     } else if (snapshot.hasData) {
        //       return const VerifyEmailPage();
        //     } else {
        //       return const SignInPage();
        //     }
        //   },
        // ),
      );
}
