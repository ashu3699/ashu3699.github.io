// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  // final user = FirebaseAuth.instance.currentUser!;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0.01), weight: 0.1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.01, end: 0.0), weight: 0.1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: -0.01), weight: 0.1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: -0.01, end: 0), weight: 0.1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0.01), weight: 0.1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.01, end: 0.0), weight: 0.1),
    ]).animate(_animationController);

    _animationController.forward().whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4e4e4),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: GestureDetector(
          onTap: (() {
            Navigator.of(context).pop();
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: .25))
              ],
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
            ),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            RotationTransition(
              turns: _animation,
              child: AnimatedContainer(
                margin: const EdgeInsets.only(bottom: 30),
                duration: const Duration(seconds: 0),
                child: Image.asset('assets/id.png'),
              ),
            ),
            RotationTransition(
              turns: _animation,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.64,
                    left: MediaQuery.sizeOf(context).width * 0.06),
                child: Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width * 0.06,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.14,
                    fontFamily: GoogleFonts.oswald().fontFamily,
                    color: const Color(0xffd3d3d3),
                  ),
                ),
              ),
            ),
            RotationTransition(
              turns: _animation,
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.76,
                  left: MediaQuery.sizeOf(context).width * 0.16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImageView(
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: Color(0xffE16D25),
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xffE16D25),
                    ),
                    backgroundColor: const Color(0xffd3d3d3),
                    // foregroundColor: const Color(0xffE16D25),
                    // data: user.uid,
                    data: 'Admin User ID',
                    version: QrVersions.auto,
                    size: MediaQuery.sizeOf(context).width * 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
