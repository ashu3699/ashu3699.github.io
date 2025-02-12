// To parse this JSON data, do
//
//     final announcement = announcementFromJson(jsonString);

import 'dart:convert';

List<Announcement> announcementFromJson(String str) => List<Announcement>.from(
    json.decode(str).map((x) => Announcement.fromJson(x)));

String announcementToJson(List<Announcement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Announcement {
  Cta? cta;
  String id;
  String title;
  String description;
  DateTime date;
  CreatedBy createdBy;
  int batch;
  String department;
  int v;

  Announcement({
    this.cta,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdBy,
    required this.batch,
    required this.department,
    required this.v,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        cta: json["cta"] == null ? null : Cta.fromJson(json["cta"]),
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        batch: json["batch"],
        department: json["department"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "cta": cta?.toJson(),
        "_id": id,
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
        "createdBy": createdBy.toJson(),
        "batch": batch,
        "department": department,
        "__v": v,
      };
}

class CreatedBy {
  String id;
  String firstName;
  String lastName;
  String photoUrl;

  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        photoUrl: json["photoUrl"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "photoUrl": photoUrl,
      };
}

class Cta {
  String link;

  Cta({required this.link});

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(link: json["link"]);

  Map<String, dynamic> toJson() => {"link": link};
}
