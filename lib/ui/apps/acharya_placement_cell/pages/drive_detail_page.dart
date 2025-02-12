// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/drive_model.dart';
import '../services/api_service.dart';
import '../utils/string_capitalize.dart';
import 'applied_page.dart';
import 'company_review_page.dart';

class DriveDetailPage extends StatefulWidget {
  const DriveDetailPage({super.key, required this.driveId});
  final String driveId;
  @override
  State<DriveDetailPage> createState() => _DriveDetailPageState();
}

class _DriveDetailPageState extends State<DriveDetailPage> {
  bool isLoading = false;
  bool isEmpy = true;
  bool applyLoading = false;

  Drive? drive;
  @override
  void initState() {
    super.initState();
    getDriveData();
  }

  Future<void> getDriveData() async {
    setState(() => isLoading = true);
    drive = await ApiService.getDriveById(driveId: widget.driveId);
    if (drive == null) {
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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/loginLogo.png',
              height: 26,
            ),
            const SizedBox(width: 8),
            const Text(
              'Placement Cell',
              style: TextStyle(
                color: ColorConstants.achBlue,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  driveBox(drive!),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
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
                        const Text(
                          'About the Role',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          drive!.jd,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 16),
                        if (drive!.bondStatement != null)
                          const Text(
                            'Bond Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        if (drive!.bondStatement != null)
                          const SizedBox(height: 8),
                        if (drive!.bondStatement != null)
                          Text(
                            drive!.bondStatement ?? 'No Bond',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        const SizedBox(height: 16),
                        if (drive!.eligibility!.skills.isNotEmpty)
                          const Text(
                            'Skills Required',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        if (drive!.eligibility!.skills.isNotEmpty)
                          const SizedBox(height: 8),
                        if (drive!.eligibility!.skills.isNotEmpty)
                          Wrap(
                            children: [
                              for (var skill in drive!.eligibility!.skills)
                                // if last skill
                                Text(
                                  '${skill.name.trim().capitalize()}, ',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        const Text(
                          'Eligibility Criteria',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tenth: ${drive!.eligibility!.tenthPercentage ?? 'Not Specified'}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Twelfth: ${drive!.eligibility!.twelfthPercentage ?? 'Not Specified'}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Graduation: ${drive!.eligibility!.graduationPercentage ?? 'Not Specified'}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget driveBox(Drive drive) {
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
                          image: NetworkImage(drive.company.logoUrl),
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
                            drive.role,
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
                          drive.company.name,
                          style: const TextStyle(
                            color: Color(0xFF1D1D1D),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        drive.bookmarked!
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: const Color(0xFF203574),
                      ),
                      onPressed: () {
                        ApiService.bookmarkDrive(driveId: drive.id)
                            .then((value) {
                          if (value) {
                            setState(() {
                              drive.bookmarked = !drive.bookmarked!;
                            });
                          }
                        });
                      },
                    ),
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
                          drive.regitrationDeadline,
                        ),
                        style: const TextStyle(
                          color: Color(0xffE67301),
                        ),
                      ),
                    ),
                    Chip(
                      avatar: Icon(
                        drive.calculatedEligibility!.eligible
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: drive.calculatedEligibility!.eligible
                            ? const Color(0xff20781F)
                            : const Color(0xffD75B87),
                        size: 20,
                      ),
                      backgroundColor: drive.calculatedEligibility!.eligible
                          ? const Color(0xffE7FBE7)
                          : const Color(0xffFEE9F2),
                      label: Text(
                          drive.calculatedEligibility!.eligible
                              ? 'Eligible'
                              : 'Not Eligible',
                          style: TextStyle(
                            color: drive.calculatedEligibility!.eligible
                                ? const Color(0xff20781F)
                                : const Color(0xffD75B87),
                          )),
                    ),
                    Chip(
                      avatar: const Icon(
                        Icons.people_alt_outlined,
                        color: Color(0xff203574),
                        size: 20,
                      ),
                      backgroundColor: const Color(0xffebeff9),
                      label: Text(
                        '${drive.noOfPositions} Positions',
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
                      label: Text('${drive.jobType.name.capitalize(true)} Role',
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
                    //   label: Text(drive.location,
                    //       style: const TextStyle(
                    //         color: Color(0xff203574),
                    //       )),
                    // ),

                    // if (drive.bondDuration != null)
                    //   Chip(
                    //     avatar: const Icon(
                    //       Icons.description_outlined,
                    //       size: 20,
                    //     ),
                    //     label: Text(
                    //       '${drive.bondDuration} Years Bond',
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
                            drive.bondApplicable!
                                ? 'Yes ${'(${drive.bondDuration} Years)'}'
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
                                .format(drive.ctc),
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
          // const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CompanyReviewPage(
                            slug: drive.company.slug,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff1e4786),
                      ),
                    ),
                    child: const Text(
                      'View Reviews',
                      style: TextStyle(
                        color: Color(0xff1e4786),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: !(drive.calculatedEligibility!.eligible &&
                            !drive.applied!)
                        ? null
                        : () {
                            setState(() {
                              applyLoading = true;
                            });
                            ApiService.applyForDrive(driveId: drive.id)
                                .then((value) {
                              setState(() {
                                applyLoading = false;
                              });
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Applied Successfully'),
                                  ),
                                );
                                //navigate to applied drives
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AppliedPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Something went wrong'),
                                  ),
                                );
                              }
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1e4786),
                    ),
                    child: applyLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : (drive.applied!)
                            ? const Text('Applied')
                            : (drive.calculatedEligibility!.eligible)
                                ? const Text('Apply Now')
                                : const Text('Not Eligible'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
