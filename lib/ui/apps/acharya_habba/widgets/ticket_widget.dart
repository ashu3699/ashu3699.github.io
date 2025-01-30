import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../constants/separator.dart';
import '../models/ticket_list.dart';

ticketWidget(BuildContext context, Ticket ticket,
// User user,
    {bool isDialog = false}) {
  Widget ticketData(Ticket ticket) {
    Icon? statusIcon;
    Color? statusColor;
    bool isPending = false;
    var image = Image.asset('assets/logo_1.png');
    switch (ticket.registration.status) {
      case 'pending':
        isPending = true;
        statusIcon = const Icon(FeatherIcons.clock);
        statusColor = const Color(0xffff9900);
        break;
      case 'confirmed':
        statusIcon = const Icon(FeatherIcons.check);
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusIcon = const Icon(FeatherIcons.x);
        statusColor = Colors.red;
        break;
      case 'refunded':
        statusIcon = const Icon(FeatherIcons.refreshCcw);
        statusColor = Colors.red;
        break;

      default:
    }

    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: statusColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(statusIcon!.icon, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      ticket.registration.status.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: GoogleFonts.oxygen().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration:
                    BoxDecoration(color: Colors.grey.withValues(alpha: .05)),
                child: QrImageView(
                  eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.circle, color: statusColor),
                  dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xff262626)),
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                  data: ticket.registration.registrationCode,
                  version: QrVersions.auto,
                  size: 200,
                  embeddedImage: image.image,
                  embeddedImageStyle:
                      QrEmbeddedImageStyle(size: const Size(150, 150)),
                  embeddedImageEmitsError: true,
                ),
              ),
              Text(
                ticket.registration.registrationCode,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: GoogleFonts.oxygen().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        const MySeparator(),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      ticket.event.name,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Timing',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '${user.displayName!.split(' ').first}\n${user.displayName!.split(' ').last}',
                          'Admin',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${ticket.event.time.split('-').first.toUpperCase()}\n${ticket.event.time.split('-').last.toUpperCase()}',
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Venue',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: GoogleFonts.rubik().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ticket.event.date,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ticket.event.venue,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isPending)
                Text(
                  'To be paid :  ₹${ticket.event.fees}',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              GestureDetector(
                onTap: () {
                  log("Tapped 1");
                  if (isDialog) {
                    log("Tapped 2");
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .pushNamed('/event_page', arguments: ticket.event);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: statusColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(FeatherIcons.eye, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'View Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  return Padding(
    padding: isDialog
        ? const EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 4)
        : const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 4),
    child: ClipRect(
      child: TicketWidget(
        width: MediaQuery.sizeOf(context).width,
        height: isDialog
            ? MediaQuery.sizeOf(context).height * 0.7
            : MediaQuery.sizeOf(context).height,
        isCornerRounded: true,
        padding: EdgeInsets.zero,
        shadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .2),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 1),
          ),
        ],
        child: ticketData(ticket),
      ),
    ),
  );
}
