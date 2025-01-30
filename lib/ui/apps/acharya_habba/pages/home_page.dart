import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageLinks = [
    "https://www.acharya.ac.in/life@acharya/img/habba/1.webp",
    "https://www.acharya.ac.in/life@acharya/img/habba/2.webp",
    "https://www.acharya.ac.in/life@acharya/img/habba/3.webp",
    "https://www.acharya.ac.in/life@acharya/img/habba/4.webp",
    "https://www.acharya.ac.in/life@acharya/img/habba/5.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: const NavigationDrawerWidget(),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: homeScreen(),
      ),
    );
  }

  Widget homeScreen() {
    return Column(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome To Acharya Habba',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          viewportFraction: 1),
                      items: [
                        for (String imgLink in imageLinks)
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(imgLink),
                                  fit: BoxFit.cover),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "At Acharya, we present the perfect platform for all-out fun and jamboree, in the form of Acharya Habba – a 3-day annual techno-cultural fest organised by Acharya Institutes, Bangalore. It draws about 25,000+ students from more than 300 colleges across Karnataka, with 50+ events taking place at the venue.",
                  style: TextStyle(height: 1.5, fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    Uri urlWeb =
                        Uri.parse("https://www.instagram.com/acharyahabba/");
                    Uri urlNative =
                        Uri.parse("instagram://user?username=acharyahabba");
                    await canLaunchUrl(urlNative)
                        ? launchUrl(urlNative)
                        : await canLaunchUrl(urlWeb)
                            ? launchUrl(urlWeb)
                            : log("Cannot Launch");
                  },
                  icon: const Icon(FontAwesomeIcons.instagram),
                  label: const Text("Follow us on Instagram"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff17295),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
