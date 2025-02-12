import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/announcement_model.dart';
import '../services/api_service.dart';
import 'applied_page.dart';
import 'bookmark_page.dart';
import 'dashboard_page.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isLoading = false;
  bool isEmpy = true;
  List<Announcement>? announcement;

  @override
  void initState() {
    super.initState();
    getAllAnnouncements();
  }

  Future<void> getAllAnnouncements() async {
    setState(() => isLoading = true);

    announcement = await ApiService.getAllAnnouncements();
    if (announcement == null) {
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
          'Announcements',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: ColorConstants.achBlue,
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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
              ? const Center(child: Text('No Announcements'))
              : ListView.builder(
                  itemCount: announcement!.length,
                  itemBuilder: (context, index) {
                    // return announcementBox(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                centerTitle: true,
                                foregroundColor: ColorConstants.achBlue,
                                title: const Text('Announcement'),
                              ),
                              body: announcementBox(index),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: announcementBox(index),
                      ),
                    );
                  },
                ),
    );
  }

  Widget announcementBox(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Image.network(
                  announcement![index].createdBy.photoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  announcement![index].title,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            announcement![index].description,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Date: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy').format(announcement![index].date),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Created By: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${announcement![index].createdBy.firstName} ${announcement![index].createdBy.lastName}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
