import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/home_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  String email = "";
  Timer? timer;

  // @override
  // void initState() {
  //   super.initState();
  //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  //   email = FirebaseAuth.instance.currentUser!.email ?? "";

  //   if (!isEmailVerified) {
  //     timer = Timer.periodic(
  //       const Duration(seconds: 3),
  //       (_) => checkEmailVerified(),
  //     );
  //   }
  // }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  // Future checkEmailVerified() async {
  //   await FirebaseAuth.instance.currentUser!.reload();
  //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  //   if (isEmailVerified) timer?.cancel();
  //   setState(() => canResendEmail = true);
  // }

  // Future sendVerificationEmail() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null && !user.emailVerified) {
  //       await user.sendEmailVerification();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           behavior: SnackBarBehavior.floating,
  //           content: Text("Email Sent!"),
  //         ),
  //       );
  //     }

  //     setState(() {
  //       canResendEmail = false;
  //     });
  //     await Future.delayed(const Duration(seconds: 5));
  //     setState(() => canResendEmail = true);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomePage()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Verify Your Email'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                        'A verification email has been sent to your email',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                    if (email != '')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          email,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                    const Text(
                        'Open your mail box and click on the link to verify',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '(Check ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Spam folder',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ' if you did not receive email)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Resend Email'),
                      onPressed:
                          // canResendEmail ? sendVerificationEmail :
                          null,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      // onPressed: (() => FirebaseAuth.instance.signOut()),
                      onPressed: null,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
