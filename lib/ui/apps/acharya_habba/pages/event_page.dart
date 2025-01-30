// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/event_list.dart';
import '../services/api_service.dart';
import '../widgets/ticket_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.event});

  final Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  String? token;

  String? registrationCode;
  bool isRegistered = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getEventData();
  }

  Future getEventData() async {
    setState(() {
      loading = true;
    });
    // token = await user.getIdToken(true);
    final resp = await ApiService.getEvent(widget.event.id, token);

    setState(() {
      token = token;
      isRegistered = resp[0];
      registrationCode = resp[1];
    });
    setState(() {
      loading = false;
    });
  }

  Future registerForEvent(bool isFree) async {
    setState(() {
      loading = true;
    });
    final res = await ApiService.registerForEvent(widget.event.id, token);

    final message = res[0];

    if (message == "Registration successful") {
      getEventData();
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Registration Successful'),
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Thank you for registering this event${isFree ? "" : ". Please pay the fees to your Event Lead and complete your registration"}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    bool isFree = event.fees == 0;
    goToTicket() async {
      var ticket = await ApiService.getTicket(registrationCode!, token);

      showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            // scrollable: true,
            // title: const Text('Ticket'),
            // contentPadding: EdgeInsets.zero,
            child: ticketWidget(ctx, ticket, isDialog: true),
            backgroundColor: Colors.transparent,
            // actions: [
            //   TextButton(
            //     child: const Text('Close'),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          );
        },
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black.withValues(alpha: .5),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          backgroundColor: const Color(0xffF6F7F9),
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: ClipRect(
            child: Container(
              color: Colors.white.withValues(alpha: .5),
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isFree ? 'Free' : '₹${event.fees}',
                      style: const TextStyle(
                        color: Color(0xff29D697),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: isRegistered
                          ? goToTicket
                          : () => registerForEvent(isFree),
                      child: Container(
                        alignment: Alignment.center,
                        width: 220,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: isRegistered
                                ? Colors.green
                                : const Color(0xffed6f5e),
                            borderRadius: BorderRadius.circular(12)),
                        child:
                            // loading
                            // ? const SizedBox(
                            //     height: 25,
                            //     width: 25,
                            //     child: CircularProgressIndicator(
                            //       strokeWidth: 2,
                            //       color: Colors.white,
                            //     ),
                            //   )
                            // :
                            Text(
                          isRegistered ? 'View Ticket' : 'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: GoogleFonts.oxygen().fontFamily),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.9,
                        image: NetworkImage(event.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          maxLines: 2,
                          style: TextStyle(
                            color: const Color(0xff2E363C),
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.raleway().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: const Color(0xfffad6d1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              FontAwesomeIcons.calendar,
                              color: Color(0xffed6f5e),
                              size: 25,
                            ),
                          ),
                          title: Text(
                            '${event.date.toUpperCase()}, ${event.time.toUpperCase()}',
                            style: TextStyle(
                              color: const Color(0xff2E363C),
                              letterSpacing: 0.7,
                              fontSize: 16,
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Scheduled for',
                            style: TextStyle(
                              color: const Color(0xff959da5),
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: const Color(0xfffad6d1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              FeatherIcons.mapPin,
                              color: Color(0xffed6f5e),
                              size: 25,
                            ),
                          ),
                          title: Text(
                            event.venue,
                            style: TextStyle(
                              color: const Color(0xff2E363C),
                              letterSpacing: 0.7,
                              fontSize: 16,
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Venue',
                            style: TextStyle(
                              color: const Color(0xff959da5),
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: const Color(0xfffad6d1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              // FeatherIcons.calendar,
                              FontAwesomeIcons.person,
                              color: Color(0xffed6f5e),
                              size: 25,
                            ),
                          ),
                          title: Text(
                            event.eventHead.name,
                            style: TextStyle(
                              color: const Color(0xff2E363C),
                              letterSpacing: 0.7,
                              fontSize: 16,
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Team Head',
                            style: TextStyle(
                              color: const Color(0xff959da5),
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              String phone = event.eventHead.phone.toString();
                              Uri url = Uri.parse("tel:$phone");
                              await canLaunchUrl(url)
                                  ? launchUrl(url)
                                  : log("Cannot Launch");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xfffceae8),
                              ),
                              child: const Text(
                                'Contact',
                                style: TextStyle(
                                  color: Color(0xffed6f5e),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: const Color(0xfffad6d1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              FontAwesomeIcons.peopleGroup,
                              color: Color(0xffed6f5e),
                              size: 25,
                            ),
                          ),
                          title: Text(
                            "${event.maxTeamSize} member${event.maxTeamSize > 1 ? 's' : ''}",
                            style: TextStyle(
                              color: const Color(0xff2E363C),
                              letterSpacing: 0.7,
                              fontSize: 16,
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Maximum Team Size',
                            style: TextStyle(
                              color: const Color(0xff959da5),
                              fontFamily: GoogleFonts.oxygen().fontFamily,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'About Event',
                          style: TextStyle(
                            color: const Color(0xff2E363C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.oxygen().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(event.description),
                        const SizedBox(height: 20),
                        Text(
                          'Rules',
                          style: TextStyle(
                            color: const Color(0xff2E363C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.oxygen().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: event.rules.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var icon = index + 1;
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xfffad6d1),
                                      borderRadius: BorderRadius.circular(150)),
                                  child: Text(
                                    icon.toString(),
                                    style: const TextStyle(
                                        color: Color(0xffed6f5e),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                minLeadingWidth: 0,
                                title: Text(
                                  event.rules[index],
                                  style: TextStyle(
                                    color: const Color(0xff2E363C),
                                    letterSpacing: 0.7,
                                    fontSize: 13,
                                    fontFamily: GoogleFonts.oxygen().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              color: const Color(0xfffad6d1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.trophy,
                                color: Color(0xffed6f5e),
                                size: 25,
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.prize,
                                    style: TextStyle(
                                      color: const Color(0xff2E363C),
                                      letterSpacing: 0.7,
                                      fontSize: 16,
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Prize',
                                    style: TextStyle(
                                      color: const Color(0xff959da5),
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
