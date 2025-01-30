import 'package:flutter/material.dart';

import '../acharya_habba.app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delayedChangeScreen();
  }

  delayedChangeScreen() async {
    await Future.delayed(const Duration(seconds: 2, microseconds: 500));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthCheck()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Image.asset(
            'assets/splash.gif',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
