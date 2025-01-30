import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_list.dart';
import '../services/api_service.dart';
import '../widgets/custom_app_bar.dart';

class EventCategoryListPage extends StatefulWidget {
  const EventCategoryListPage({super.key});

  @override
  State<EventCategoryListPage> createState() => _EventCategoryListPageState();
}

class _EventCategoryListPageState extends State<EventCategoryListPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  String? token;

  Map emojiList = {
    'music': '🎵',
    'dance': '🕺',
    'gaming': '🎮',
    'technical': '💻',
    'technology': '💻',
    'literary': '📚',
    'lifestyle': '🏡',
    'instracollege': '🎓',
    'business': '💼',
    'mestori': '📚',
    'photography': '📷',
    'fun': '🎢',
    'kannada': '📙',
    'sports': '🏆',
    'centralized': '🏘',
    'miscellaneous': '🎁',
    'arts': '🎨',
    'cultural': '🎭',
  };

  // @override
  // void initState() {
  //   super.initState();
  //   getToken();
  // }

  // Future getToken() async {
  //   token = await user.getIdToken(true);
  //   log(token.toString());
  //   setState(() {
  //     token = token;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff5f8fa),
        appBar: customAppBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<List<Event>>(
            future: ApiService.getAllEvents(token),
            builder: (context, snapshot) {
              List<Event>? eventList = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Loading...'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: buildEvents(eventList!),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCategory(eventList, pageController) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          height: 350,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: eventList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              Event event = eventList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/event_page', arguments: event);
                },
                child: Container(
                  height: 300,
                  margin: const EdgeInsets.only(
                      top: 8, bottom: 12, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: .2),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: NetworkImage(event.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: .8),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: .2),
                                      blurRadius: 30,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${event.date.toUpperCase().split(' ')[0]}\n${event.date.toUpperCase().split(' ')[1]}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 245, 11, 11),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xff333333),
                                fontFamily: GoogleFonts.rubik().fontFamily,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  FeatherIcons.clock,
                                  size: 15,
                                  color: Color.fromARGB(255, 245, 11, 11),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  event.time,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        const Color.fromARGB(255, 245, 11, 11),
                                    fontFamily: GoogleFonts.oxygen().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  FeatherIcons.mapPin,
                                  size: 15,
                                  color: Color(0xff959da5),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  event.venue,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: const Color(0xff959da5),
                                    fontFamily: GoogleFonts.oxygen().fontFamily,
                                  ),
                                ),
                                const Spacer(),
                                Text("${index + 1}/${eventList.length}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xff959da5),
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                    )),
                                const SizedBox(width: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildEvents(List<Event> eventList) {
    eventList.sort((a, b) => b.date.compareTo(a.date));

    //group events by date
    Map<String, List<Event>> groupedEvents = {};
    for (Event event in eventList.reversed) {
      String category = event.category;
      if (groupedEvents.containsKey(category)) {
        groupedEvents[category]!.add(event);
      } else {
        groupedEvents[category] = [event];
      }
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: groupedEvents.length,
      itemBuilder: (context, index) {
        String category = groupedEvents.keys.toList()[index];
        List<Event>? events = groupedEvents[category];
        var heading = emojiList[category.toLowerCase()] ?? '🎁';
        PageController pageController = PageController();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "$heading ${category.substring(0, 1).toUpperCase()}${category.substring(1)}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.black54,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            buildCategory(events, pageController),
            const SizedBox(height: 15)
          ],
        );
      },
    );
  }
}
