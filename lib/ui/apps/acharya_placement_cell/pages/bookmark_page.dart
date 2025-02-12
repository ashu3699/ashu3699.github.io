import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/drive_model.dart';
import '../services/api_service.dart';
import '../utils/string_capitalize.dart';
import 'announcement_page.dart';
import 'applied_page.dart';
import 'dashboard_page.dart';
import 'drive_detail_page.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  bool isLoading = false;
  bool isEmpy = true;
  List<Drive>? drives = [];
  @override
  void initState() {
    super.initState();
    getAllBookmarkedDrives();
  }

  Future<void> getAllBookmarkedDrives() async {
    setState(() => isLoading = true);

    drives = await ApiService.getAllBookmarkedDrives();
    if (drives!.isEmpty) {
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
          'Bookmarked Drives',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: ColorConstants.achBlue,
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
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
              ? const Center(child: Text('No Bookmarked Drives'))
              : ListView.builder(
                  itemCount: drives!.length,
                  itemBuilder: (context, index) {
                    return driveBox(index);
                  },
                ),
    );
  }

  Widget driveBox(int index) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withValues(alpha: .5),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(drives![index].company.logoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              drives![index].role,
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            drives![index].company.name,
                            style: const TextStyle(
                              color: Color(0xFF1D1D1D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // IconButton(
                      //   icon: Icon(
                      //     drives![index].bookmarked!
                      //         ? Icons.bookmark
                      //         : Icons.bookmark_border_outlined,
                      //     color: const Color(0xFF203574),
                      //   ),
                      //   onPressed: () {
                      //     ApiService.bookmarkDrive(driveId: drives![index].id)
                      //         .then((value) {
                      //       if (value) {
                      //         setState(() {
                      //           drives![index].bookmarked =
                      //               !drives![index].bookmarked!;
                      //         });
                      //       }
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.timer_outlined,
                          color: Color(0xffE67301),
                          size: 20,
                        ),
                        backgroundColor: const Color(0xffFFF1E5),
                        label: Text(
                          DateFormat('dd MMM yyyy, hh:mm a').format(
                            drives![index].regitrationDeadline,
                          ),
                          style: const TextStyle(
                            color: Color(0xffE67301),
                          ),
                        ),
                      ),
                      Chip(
                        avatar: const Icon(
                          Icons.people_alt_outlined,
                          color: Color(0xff203574),
                          size: 20,
                        ),
                        backgroundColor: const Color(0xffebeff9),
                        label: Text(
                          '${drives![index].noOfPositions} Positions',
                          style: const TextStyle(
                            color: Color(0xff203574),
                          ),
                        ),
                      ),
                      Chip(
                        avatar: const Icon(
                          Icons.work_outline_outlined,
                          color: Color(0xff203574),
                          size: 20,
                        ),
                        backgroundColor: const Color(0xffebeff9),
                        label: Text(
                            '${drives![index].jobType.name.capitalize(true)} Role',
                            style: const TextStyle(
                              color: Color(0xff203574),
                            )),
                      ),
                      // Chip(
                      //   avatar: const Icon(
                      //     Icons.location_on_outlined,
                      //     color: Color(0xff203574),
                      //     size: 20,
                      //   ),
                      //   backgroundColor: const Color(0xffebeff9),
                      //   label: Text(drives![index].location,
                      //       style: const TextStyle(
                      //         color: Color(0xff203574),
                      //       )),
                      // ),
                      Chip(
                        avatar: Icon(
                          drives![index].calculatedEligibility!.eligible
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          color: drives![index].calculatedEligibility!.eligible
                              ? const Color(0xff20781F)
                              : const Color(0xffD75B87),
                          size: 20,
                        ),
                        backgroundColor:
                            drives![index].calculatedEligibility!.eligible
                                ? const Color(0xffE7FBE7)
                                : const Color(0xffFEE9F2),
                        label: Text(
                            drives![index].calculatedEligibility!.eligible
                                ? 'Eligible'
                                : 'Not Eligible',
                            style: TextStyle(
                              color:
                                  drives![index].calculatedEligibility!.eligible
                                      ? const Color(0xff20781F)
                                      : const Color(0xffD75B87),
                            )),
                      ),
                      // if (drives![index].bondDuration != null)
                      //   Chip(
                      //     avatar: const Icon(
                      //       Icons.description_outlined,
                      //       size: 20,
                      //     ),
                      //     label: Text(
                      //       '${drives![index].bondDuration} Years Bond',
                      //     ),
                      //   ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bond',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              drives![index].bondApplicable!
                                  ? 'Yes ${'(${drives![index].bondDuration} Years)'}'
                                  : 'No',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  .format(drives![index].ctc),
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
                            driveId: drives![index].id,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Text(
                            drives![index].calculatedEligibility!.eligible
                                ? 'Apply Now'
                                : 'View Details',
                            style: const TextStyle(
                              // color: Colors.white,
                              color: Color(0xFF203574),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xFF203574),
                          ),
                          const SizedBox(width: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
