import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/event_list.dart';
import '../models/event_register.dart';
import '../models/ticket_list.dart';

class ApiService {
  static const String baseUrl = 'http://example.com/api';

  static final List<Event> fakeEvents = [
    Event(
      maxTeamSize: 5,
      id: "evt123",
      name: "Hackathon 2025",
      description:
          "A 24-hour coding marathon where teams solve real-world problems.",
      date: "6 Mar",
      fullDate: DateTime(2025, 3, 6),
      time: "10:00 AM - 10:00 PM",
      rules: [
        "Max 5 members per team",
        "No pre-built projects",
        "Judging based on innovation"
      ],
      venue: "Tech Hall, Block A",
      image:
          "https://cdn.prod.website-files.com/646caab5700fe0d1824a61b9/65170c1e01c86d489de784dd_hackathon.png",
      prize: "₹50,000",
      fees: 500,
      maxRegistrations: 50,
      onlyAcharyans: false,
      createdBy: "Admin",
      status: "Open",
      category: "Technology",
      eventHead: EventHead(
        name: "John Doe",
        phone: "+91 9876543210",
        email: "johndoe@example.com",
      ),
    ),
    Event(
      maxTeamSize: 4,
      id: "evt101",
      name: "Code Wars",
      description:
          "A competitive coding event to test your problem-solving skills.",
      date: "5 Mar",
      fullDate: DateTime(2025, 3, 5),
      time: "9:00 AM - 1:00 PM",
      rules: [
        "Max 4 members per team",
        "Use of internet is prohibited",
        "Coding languages allowed: C++, Java, Python"
      ],
      venue: "Computer Lab, Block B",
      image:
          "https://2022.codeavour.org/wp-content/uploads/2022/08/Codeavour-2022-MainInternal.png",
      prize: "₹20,000",
      fees: 100,
      maxRegistrations: 40,
      onlyAcharyans: false,
      createdBy: "Admin",
      status: "Open",
      category: "Technology",
      eventHead: EventHead(
        name: "Rahul Sharma",
        phone: "+91 9988776655",
        email: "rahulsharma@example.com",
      ),
    ),
    Event(
      maxTeamSize: 1,
      id: "evt102",
      name: "Solo Dance Battle",
      description:
          "Show your best moves and compete against the finest dancers!",
      date: "6 Mar",
      fullDate: DateTime(2025, 3, 6),
      time: "5:00 PM - 7:00 PM",
      rules: [
        "Solo performance only",
        "Max time: 3 minutes",
        "Props allowed but must be managed by the participant"
      ],
      venue: "Main Auditorium",
      image:
          "https://a.storyblok.com/f/170319/500x500/348cd95235/blog_dance-battle-formats-min.jpg",
      prize: "₹15,000",
      fees: 150,
      maxRegistrations: 30,
      onlyAcharyans: false,
      createdBy: "Cultural Committee",
      status: "Open",
      category: "Cultural",
      eventHead: EventHead(
        name: "Sneha Kapoor",
        phone: "+91 9876543211",
        email: "snehakapoor@example.com",
      ),
    ),
    Event(
      maxTeamSize: 6,
      id: "evt103",
      name: "Battle of Bands",
      description:
          "Bring your band and rock the stage in this electrifying music competition!",
      date: "7 Mar",
      fullDate: DateTime(2025, 3, 7),
      time: "6:00 PM - 9:00 PM",
      rules: [
        "Max 6 members per band",
        "Performance time: 10 minutes",
        "No explicit or offensive lyrics"
      ],
      venue: "Outdoor Stage",
      image:
          "https://cdn.dribbble.com/users/2286676/screenshots/6851466/battle-of-the-bands-1_4x.jpg",
      prize: "₹30,000",
      fees: 500,
      maxRegistrations: 15,
      onlyAcharyans: false,
      createdBy: "Music Club",
      status: "Open",
      category: "Music",
      eventHead: EventHead(
        name: "Arjun Verma",
        phone: "+91 9765432100",
        email: "arjunverma@example.com",
      ),
    ),
    Event(
      maxTeamSize: 2,
      id: "evt104",
      name: "Treasure Hunt",
      description:
          "Solve clues, find hidden treasures, and win exciting prizes!",
      date: "7 Mar",
      fullDate: DateTime(2025, 3, 7),
      time: "11:00 AM - 2:00 PM",
      rules: [
        "Teams of 2 only",
        "No external help allowed",
        "The team that finds the final treasure first wins"
      ],
      venue: "College Campus",
      image:
          "https://www.wanderquest.in/monthly-subscription-boxes-for-kids-6-to-12-years/modules//smartblog/images/15-single-default.jpg",
      prize: "₹10,000",
      fees: 50,
      maxRegistrations: 50,
      onlyAcharyans: true,
      createdBy: "Student Council",
      status: "Upcoming",
      category: "Fun",
      eventHead: EventHead(
        name: "Megha Patel",
        phone: "+91 9898767654",
        email: "meghapatel@example.com",
      ),
    ),
    Event(
      maxTeamSize: 11,
      id: "evt105",
      name: "Football Tournament",
      description: "A 5-a-side football competition for sports enthusiasts.",
      date: "9 Mar",
      fullDate: DateTime(2025, 3, 9),
      time: "2:00 PM - 6:00 PM",
      rules: [
        "Teams of 5 + 1 substitute",
        "Match duration: 20 minutes",
        "FIFA rules apply"
      ],
      venue: "College Sports Ground",
      image:
          "https://static.vecteezy.com/system/resources/previews/023/296/178/non_2x/football-tournament-lettering-with-realistic-soccer-ball-and-black-splatter-effect-on-white-background-vector.jpg",
      prize: "₹25,000",
      fees: 300,
      maxRegistrations: 20,
      onlyAcharyans: false,
      createdBy: "Sports Committee",
      status: "Open",
      category: "Sports",
      eventHead: EventHead(
        name: "Ramesh Kumar",
        phone: "+91 9123456789",
        email: "rameshkumar@example.com",
      ),
    ),
    Event(
      maxTeamSize: 1,
      id: "evt106",
      name: "Photography Contest",
      description: "Capture the best shots based on the given theme.",
      date: "10 Mar",
      fullDate: DateTime(2025, 3, 10),
      time: "10:00 AM - 4:00 PM",
      rules: [
        "Theme will be announced on the spot",
        "Only DSLR and phone cameras allowed",
        "No AI-generated or stock images"
      ],
      venue: "Art Room, Block C",
      image:
          "https://i0.wp.com/www.nrtec.in/wp-content/uploads/2018/12/photography-contest-NEC.jpg",
      prize: "₹5,000",
      fees: 100,
      maxRegistrations: 100,
      onlyAcharyans: false,
      createdBy: "Photography Club",
      status: "Open",
      category: "Arts",
      eventHead: EventHead(
        name: "Kiran Rao",
        phone: "+91 9871234567",
        email: "kiranrao@example.com",
      ),
    ),
  ];

  static Future<List<Event>> getAllEvents(String? token) async {
    return fakeEvents;
  }

  static getEvent(String eventId, String? token) async {
    int id = fakeEvents.indexWhere((element) => element.id == eventId);
    return [id < 3, eventId];
  }

  static getDevelopersData(String? token) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final response = await http.get(
      Uri.parse('$baseUrl/attendee/developers'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    final body = json.decode(response.body);
    if (body['success']) {
      log(body.toString());
      return body['data']['developers'];
    }
    return false;
  }

  static Future<List<Event>> getEventsByCategory(
      String category, String? token) async {
    late List<Event> list;
    final response = await http.get(
      Uri.parse('$baseUrl/attendee/events/category/$category'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final data = body['data']['events'] as List;
      list = data.map<Event>((json) => Event.fromJson(json)).toList();
    }
    return list;
  }

  static Future registerForEvent(String eventId, String? token) async {
    late RegistrationData registrationData;
    final response = await http.post(
      Uri.parse('$baseUrl/attendee/events/$eventId/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    final body = json.decode(response.body);

    if (body['success']) {
      final data = body['data'];
      final message = data['message'];
      registrationData = RegistrationData.fromJson(data['registration']);

      return [message, registrationData];
    } else {
      final message = body['error']['message'];
      return [message, null];
    }
  }

  static Future getTicket(String registrationCode, String? token) async {
    Event event =
        fakeEvents.firstWhere((element) => element.id == registrationCode);
    final registration = RegistrationData(
      eventId: event.id,
      uid: 'uid123',
      registeredOn: 1632960000,
      status: ['pending', 'confirmed', 'rejected'][math.Random().nextInt(2)],
      confirmedBy: 'Admin',
      confirmedOn: 1632960000,
      maxTeamSize: 5,
      id: 'reg123',
      registrationCode: 'ABCD1234',
    );
    return Ticket(event: event, registration: registration);
  }

  static Future<List<Ticket>> getAllTickets(String? token) async {
    List<Ticket> tickets = [];
    for (var event in fakeEvents) {
      final registration = RegistrationData(
        eventId: event.id,
        uid: 'uid123',
        registeredOn: 1632960000,
        status: ['pending', 'confirmed', 'rejected'][math.Random().nextInt(2)],
        confirmedBy: 'Admin',
        confirmedOn: 1632960000,
        maxTeamSize: 5,
        id: 'reg123',
        registrationCode: 'ABCD1234',
      );
      tickets.add(Ticket(event: event, registration: registration));
    }

    return tickets.sublist(0, 3);
  }

  static Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }
}
