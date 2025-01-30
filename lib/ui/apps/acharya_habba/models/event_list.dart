import 'package:intl/intl.dart';

class Event {
  final int maxTeamSize;
  final String id;
  final String name;
  final String description;
  final String date;
  final DateTime fullDate;
  final String time;
  final List rules;
  final String venue;
  final String image;
  final String prize;
  final int fees;
  final int maxRegistrations;
  final bool onlyAcharyans;
  final String createdBy;
  final String status;
  final String category;
  final EventHead eventHead;

  Event({
    required this.maxTeamSize,
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.fullDate,
    required this.time,
    required this.rules,
    required this.venue,
    required this.image,
    required this.prize,
    required this.fees,
    required this.maxRegistrations,
    required this.onlyAcharyans,
    required this.createdBy,
    required this.status,
    required this.category,
    required this.eventHead,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        maxTeamSize: json['maxTeamSize'] ?? '',
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        date: DateFormat('dd MMM')
            .format(DateTime.parse(json['date']))
            .toString(),
        fullDate: DateTime.parse(json['date']),
        time: json['time'] ?? '',
        rules: json['rules'] ?? '',
        venue: json['venue'] ?? '',
        image: json['image'] ?? '',
        prize: json['prize'] ?? '0',
        fees: json['fees'] ?? '',
        maxRegistrations: json['maxRegistrations'] ?? '',
        onlyAcharyans: json['onlyAcharyans'] ?? '',
        createdBy: json['createdBy'] ?? '',
        status: json['status'] ?? '',
        category: json['category'] ?? '',
        eventHead: EventHead.fromJson(json['eventHead']),
      );
}

class EventHead {
  final String name;
  final String phone;
  final String email;

  EventHead({
    required this.name,
    required this.phone,
    required this.email,
  });

  factory EventHead.fromJson(Map<String, dynamic> json) => EventHead(
        name: (json['name'] ?? '') as String,
        phone: (json['phone'] ?? '') as String,
        email: (json['email'] ?? '') as String,
      );
}
