import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_app_bar.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  bool loading = false;

  List<DevModel> developers = [];
  Future getDevelopersData() async {
    setState(() {
      loading = true;
    });

    developers.clear();

    developers.add(
      DevModel(
        id: '1',
        name: 'Ashutosh Kumar',
        photo:
            'https://instagram.fblr2-2.fna.fbcdn.net/v/t51.2885-19/475214692_1146928120208484_618248737535160912_n.jpg?_nc_ht=instagram.fblr2-2.fna.fbcdn.net&_nc_cat=100&_nc_ohc=eWN1oBK2MqAQ7kNvgHWPlXC&_nc_gid=da80b8dea7f048978bcfa8f4f60c64d4&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_AYC9O2bsXz2Y-DQ8avUjspKIbm7YD36sGs7XSrAZhreFHg&oe=67A0F8EE&_nc_sid=7d3ac5',
        contribution: 'Mobile App Developer',
        instagram: 'https://www.instagram.com/demo/',
        linkedin: 'https://www.linkedin.com/in/-ashutosh-kumar-/',
      ),
    );

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDevelopersData();
  }

  Widget devCard({
    String name = '',
    String role = '',
    String imageLink = '',
    String instagram = '',
    String linkedIn = '',
  }) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 4),
              color: Color.fromARGB(73, 110, 53, 62),
              blurRadius: 6,
              spreadRadius: 2),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        name,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        role,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (linkedIn != '')
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  linkedIn = linkedIn.startsWith("https")
                                      ? linkedIn
                                      : "https://$linkedIn";
                                  Uri url = Uri.parse(linkedIn);
                                  await canLaunchUrl(url)
                                      ? launchUrl(url,
                                          mode: LaunchMode.externalApplication)
                                      : log("Cannot Launch linkedin");
                                },
                                child: Image.asset(
                                  'assets/linkedin.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (instagram != '')
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Uri url = Uri.parse(instagram);
                                  await canLaunchUrl(url)
                                      ? launchUrl(url,
                                          mode: LaunchMode.externalApplication)
                                      : log("Cannot Launch Instagram");
                                },
                                child: Image.asset(
                                  'assets/insta.png',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: () async {
          getDevelopersData();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Developers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: developers.length,
                          itemBuilder: (context, i) {
                            return devCard(
                                name: developers[i].name,
                                role: developers[i].contribution,
                                imageLink: developers[i].photo,
                                instagram: developers[i].instagram,
                                linkedIn: developers[i].linkedin);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class DevModel {
  String id;
  String name;
  String photo;
  String contribution;
  String instagram;
  String linkedin;

  DevModel(
      {required this.id,
      required this.contribution,
      required this.instagram,
      required this.linkedin,
      required this.name,
      required this.photo});

  factory DevModel.fromMap(Map<String, dynamic> map) {
    return DevModel(
      id: map.containsKey('_id')
          ? (map['_id'] ?? '_id null')
          : '_id not present',
      contribution:
          map.containsKey('contribution') ? (map['contribution'] ?? '') : '',
      instagram: map.containsKey('instagram') ? (map['instagram'] ?? '') : '',
      linkedin: map.containsKey('linkedin') ? (map['linkedin'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      photo: map.containsKey('photoUrl') ? (map['photoUrl'] ?? '') : '',
    );
  }
}
