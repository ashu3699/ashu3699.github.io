// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/main_model.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../utils/string_validation.dart';
import 'dashboard_page.dart';
import 'profile_setup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool isEmailValid = false;
  bool securePass = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(body: loginBody());
  }

  Widget loginBody() {
    return Container(
      height: SizeConfig.screenHeight,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/placement_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: SizeConfig.screenHeight / 1.85,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 10,
          vertical: SizeConfig.blockSizeVertical * 3,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log in',
              style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 5.5,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  TextFormField(
                    onChanged: (value) =>
                        setState(() => isEmailValid = value.isAcharyaEmail()),
                    controller: emailCtrl,
                    validator: (_) => isEmailValid ? null : "Check your email",
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: GoogleFonts.ubuntu(),
                      label: Text(
                        'Email',
                        style: GoogleFonts.ubuntu(color: Colors.black),
                      ),
                      suffixIcon:
                          isEmailValid ? const Icon(Icons.check_rounded) : null,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  TextFormField(
                    controller: passwordCtrl,
                    obscureText: securePass,
                    validator: (value) =>
                        value!.isEmpty || value == '' ? "Enter password" : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => securePass = !securePass),
                        icon: Icon(
                          securePass
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.ubuntu(),
                      label: Text(
                        'Password',
                        style: GoogleFonts.ubuntu(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        _formKey.currentState!.save();
                        var message = await AuthService().login(
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text,
                        );
                        log(message.toString());
                        if (message!.toLowerCase().contains('success')) {
                          // bool isEmailVerified =
                          //     auth.currentUser!.emailVerified;
                          // if (isEmailVerified) {
                          ProfileProgressModel? progress =
                              await ApiService.getStudentProgress();
                          if (progress!.progress!.completed!) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DashboardPage(),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ProfileSetupPage(),
                              ),
                            );
                          }
                          // } else {
                          //   message = "Please verify your email";
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) => const VerifyEmailPage(),
                          //     ),
                          //   );
                          // }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(message),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: SizeConfig.safeBlockVertical * 7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorConstants.achBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Sign in',
                              style: GoogleFonts.ubuntu(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  // GestureDetector(
                  // onTap: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => Theme(
                  //         data: ThemeData(
                  //           textButtonTheme: TextButtonThemeData(
                  //             style: TextButton.styleFrom(
                  //               foregroundColor: ColorConstants.achBlue,
                  //             ),
                  //           ),
                  //           outlinedButtonTheme: OutlinedButtonThemeData(
                  //             style: OutlinedButton.styleFrom(
                  //               foregroundColor: ColorConstants.achBlue,
                  //             ),
                  //           ),
                  //         ),
                  //         child: ForgotPasswordScreen(
                  //           auth: auth,
                  //           email: emailCtrl.text.trim(),
                  //           // resizeToAvoidBottomInset: true,
                  //           subtitleBuilder: (context) => const Text(
                  //             'Enter your email address and we will send you a link to reset your password',
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //           headerBuilder: (context, constraints, size) =>
                  //               SizedBox(
                  //             height: constraints.maxHeight * 0.5,
                  //             width: constraints.maxWidth * 0.5,
                  //             child: Image.asset(
                  //               'assets/icons/loginLogo.png',
                  //               fit: BoxFit.contain,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // },
                  //   child: Container(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Forgot Password ?',
                  //       style: GoogleFonts.ubuntu(
                  //         fontSize: SizeConfig.safeBlockHorizontal * 4,
                  //         color: ColorConstants.achBlue,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Unable to login?',
                        style: GoogleFonts.ubuntu(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                      GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   toggle = !toggle;
                          // });
                        },
                        child: Text(
                          'Contact Us',
                          style: GoogleFonts.ubuntu(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: ColorConstants.achBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
