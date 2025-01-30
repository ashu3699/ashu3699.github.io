import 'dart:async';

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

  String email = "";
  Timer? timer;

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

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
                      onPressed: null,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
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
