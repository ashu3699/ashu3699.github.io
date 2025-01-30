import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_list.dart';
import '../services/api_service.dart';
import '../widgets/custom_app_bar.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  // final user = FirebaseAuth.instance.currentUser!;
  String? token;
  String searchString = "";
  // @override
  // void initState() {
  //   super.initState();
  //   getToken();
  // }

  // Future getToken() async {
  //   token = await user.getIdToken(true);
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: .2),
                      blurRadius: 30,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchString = value.toLowerCase();
                    });
                  },
                  decoration: const InputDecoration(
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 245, 11, 11)),
                    border: InputBorder.none,
                    labelText: 'Search Event',
                    suffixIconColor: Color.fromARGB(255, 245, 11, 11),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 245, 11, 11),
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Event>>(
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
                        return Center(child: Text('$snapshot.error'));
                      } else {
                        return searchString != ""
                            ? searchEvent(eventList)
                            : buildEvents(eventList!);
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchEvent(eventList) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: eventList.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = eventList[index];
          return event.name.toLowerCase().contains(searchString)
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/event_page', arguments: event);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    padding: const EdgeInsets.all(12),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .2),
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: AspectRatio(
                              aspectRatio: 3 / 3.7,
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/load.png',
                                  image: event.image,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset('assets/load.png',
                                        fit: BoxFit.cover);
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event.date} \u2022 ${event.time.toUpperCase()}",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 245, 11, 11),
                                  fontFamily: GoogleFonts.oxygen().fontFamily,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  event.name,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: const Color(0xff333333),
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
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
                      ],
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }

  Widget buildEvents(List<Event> eventList) {
    eventList.sort((a, b) => b.fullDate.compareTo(a.fullDate));

    //group events by date
    Map<DateTime, List<Event>> groupedEvents = {};
    for (Event event in eventList.reversed) {
      DateTime date = event.fullDate;
      if (groupedEvents.containsKey(date)) {
        groupedEvents[date]!.add(event);
      } else {
        groupedEvents[date] = [event];
      }
    }

    return RawScrollbar(
      thumbColor: const Color.fromARGB(255, 245, 11, 11),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: groupedEvents.length,
        itemBuilder: (context, index) {
          DateTime date = groupedEvents.keys.toList()[index];
          List<Event>? events = groupedEvents[date];
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  groupedEvents[date]![0].date.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (Event event in events!)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/event_page', arguments: event);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    padding: const EdgeInsets.all(12),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: .2),
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: AspectRatio(
                              aspectRatio: 3 / 3.7,
                              child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/load.png',
                                  image: event.image,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset('assets/load.png',
                                        fit: BoxFit.cover);
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event.date} \u2022 ${event.time.toUpperCase()}",
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: const Color.fromARGB(255, 245, 11, 11),
                                  fontFamily: GoogleFonts.oxygen().fontFamily,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  event.name,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: const Color(0xff333333),
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
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
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 15)
            ],
          );
        },
      ),
    );
  }
}
