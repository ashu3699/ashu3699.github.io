import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/navigation_item.dart';
import '../provider/navigation_provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    final name = 'Admin';
    final email = 'admin@acharya.ac.in';
    const photo = 'assets/logo_2.png';
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: ListView(
        children: [
          buildHeader(name: name, email: email, photo: photo),
          Container(
            padding: padding,
            child: Column(
              children: [
                buildMenuItem(
                  context,
                  item: NavigationItem.eventList,
                  title: 'Event List',
                  icon: FeatherIcons.calendar,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.eventList),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.eventCategory,
                  title: 'Event Category',
                  icon: FeatherIcons.grid,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.eventCategory),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.myEvents,
                  title: 'My Tickets',
                  icon: FeatherIcons.bookmark,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.myEvents),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.developers,
                  title: 'Developers',
                  icon: FeatherIcons.code,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.developers),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.support,
                  title: 'Support',
                  icon: FeatherIcons.mail,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.support),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  item: NavigationItem.signOut,
                  title: 'Sign Out',
                  icon: FeatherIcons.logOut,
                  isColored: true,
                  onClicked: () =>
                      selectedItem(context, NavigationItem.signOut),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(
          {required String? name,
          required String? email,
          required String photo,
          VoidCallback? onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(photo, height: 80),
                    const SizedBox(height: 20),
                    Text(
                      name!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email!,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.rubik().fontFamily,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.8,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
    BuildContext context, {
    required NavigationItem item,
    required String title,
    required IconData icon,
    bool isColored = false,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      minLeadingWidth: 0,
      selectedTileColor: Colors.grey.shade100,
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.rubik().fontFamily,
            fontWeight: FontWeight.bold),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
    switch (item) {
      case NavigationItem.eventList:
        Navigator.of(context).popAndPushNamed('/event_list');
        break;
      case NavigationItem.eventCategory:
        Navigator.of(context).popAndPushNamed('/event_category');
        break;
      case NavigationItem.myEvents:
        Navigator.of(context).popAndPushNamed('/my_events');
        break;
      case NavigationItem.developers:
        Navigator.of(context).popAndPushNamed('/dev');
        break;
      case NavigationItem.support:
        launchSupport();
        break;
      // case NavigationItem.signOut:
      //   FirebaseAuth.instance.signOut();
      // break;
      default:
    }
  }
}

void launchSupport() async {
  Uri url = Uri.parse("mailto:acharyahabba@acharya.ac.in");
  await canLaunchUrl(url) ? launchUrl(url) : log("Cannot Launch");
}
