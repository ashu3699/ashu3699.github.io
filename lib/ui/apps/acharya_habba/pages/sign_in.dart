import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool securePass = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purpleAccent,
                  Colors.amber,
                  Colors.amber,
                ]),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(height: 150, child: Image.asset("assets/logo.png")),
              Flexible(
                child: Text(
                  'ACHARYA HABBA\n2022',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.righteous(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Please Login to Your Account",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        height: 60,
                        child: TextField(
                          controller: emailCtrl,
                          decoration: const InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.orange,
                            ),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        height: 60,
                        child: TextField(
                          controller: passwordCtrl,
                          obscureText: securePass,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.zero,
                              icon: Icon(securePass
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye),
                              color: Colors.orange,
                              onPressed: () {
                                setState(() {
                                  securePass = !securePass;
                                });
                              },
                            ),
                            labelText: "Password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed('/forgot_password');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          var message = AuthService().login(
                            email: emailCtrl.text.trim(),
                            password: passwordCtrl.text,
                          );
                          if (message!.contains('Demo')) {
                            Navigator.of(context).pushNamed('/home');
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(message),
                            ),
                          );
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.roboto().fontFamily,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                            ),
                            onPressed: () async {
                              // Navigator.of(context).pushNamed('/sign_up');
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Uri url = Uri.parse(
                                  "mailto:acharyahabba@acharya.ac.in");
                              await canLaunchUrl(url)
                                  ? launchUrl(url)
                                  : log("Cannot Launch");
                            },
                            child: Text(
                              "Need Help?",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
