import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/applied_model.dart';
import '../services/api_service.dart';
import '../utils/string_capitalize.dart';
import 'announcement_page.dart';
import 'bookmark_page.dart';
import 'dashboard_page.dart';
import 'drive_detail_page.dart';

class AppliedPage extends StatefulWidget {
  const AppliedPage({super.key});

  @override
  State<AppliedPage> createState() => _AppliedPageState();
}

class _AppliedPageState extends State<AppliedPage> {
  bool isLoading = false;
  bool isEmpy = true;

  List<Application>? application;
  @override
  void initState() {
    super.initState();
    getAllAppliedDrives();
  }

  Future<void> getAllAppliedDrives() async {
    setState(() => isLoading = true);

    application = await ApiService.getAllAppliedDrives();
    if (application == null) {
      isEmpy = true;
    } else {
      isEmpy = false;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.achBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: ColorConstants.achBlue,
        title: const Text(
          'Applied Jobs',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: ColorConstants.achBlue,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index) {
          // setState(() => currentIndex = index);
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()));
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AppliedPage()));
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnnouncementPage()));
              break;
            case 3:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookmarkPage()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outlined),
            label: 'Applied Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement_outlined),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_added_outlined),
            label: 'Bookmarks',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isEmpy
              ? const Center(child: Text('No Applied Jobs'))
              : ListView.builder(
                  itemCount: application!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(application![index].drive.company.name),
                            subtitle: Text(application![index].drive.role),
                            trailing:
                                Text(application![index].status.capitalize()),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Salary',
                                        style: TextStyle(
                                          color: Color(0xFF1D1D1D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'en_IN',
                                                symbol: '₹',
                                                decimalDigits: 0)
                                            .format(
                                                application![index].drive.ctc),
                                        style: const TextStyle(
                                          color: Color(0xFF203574),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Venue',
                                        style: TextStyle(
                                          color: Color(0xFF1D1D1D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        application![index].drive.venue,
                                        style: const TextStyle(
                                          color: Color(0xFF203574),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFEBEFF9),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(8),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    //navigate to apply page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DriveDetailPage(
                                          driveId: application![index].drive.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: const [
                                        Text(
                                          'View Details',
                                          style: TextStyle(
                                            // color: Colors.white,
                                            color: Color(0xFF203574),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Color(0xFF203574),
                                        ),
                                        SizedBox(width: 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
