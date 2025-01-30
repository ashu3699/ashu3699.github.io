import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget customAppBar(context,
    {isProfileVisible = true, isBlack = true}) {
  return AppBar(
    actions: [
      if (isProfileVisible)
        IconButton(
          icon: const Icon(
            Icons.badge,
            color: Color(0xfff17295),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        )
    ],
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: isBlack ? Brightness.dark : Brightness.dark,
      statusBarIconBrightness: isBlack ? Brightness.dark : Brightness.light,
    ),
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: isBlack ? Colors.black : Colors.white,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/square_logo.png',
            height: 30,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Acharya Habba',
          style: TextStyle(
            color: isBlack ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.rubik().fontFamily,
          ),
        ),
      ],
    ),
  );
}
