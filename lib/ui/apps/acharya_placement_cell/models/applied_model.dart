// To parse this JSON data, do
//
//     final application = applicationFromJson(jsonString);

import 'dart:convert';

import 'drive_model.dart';

List<Application> applicationFromJson(String str) => List<Application>.from(
    json.decode(str).map((x) => Application.fromJson(x)));

String applicationToJson(List<Application> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Application {
  String id;
  String uid;
  Drive drive;
  dynamic answers;
  String status;
  String appliedBy;
  int appliedOn;

  Application({
    required this.id,
    required this.uid,
    required this.drive,
    this.answers,
    required this.status,
    required this.appliedBy,
    required this.appliedOn,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["_id"],
        uid: json["uid"],
        drive: Drive.fromJson(json["drive"]),
        answers: json["answers"],
        status: json["status"],
        appliedBy: json["appliedBy"],
        appliedOn: json["appliedOn"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "drive": drive.toJson(),
        "answers": answers,
        "status": status,
        "appliedBy": appliedBy,
        "appliedOn": appliedOn,
      };
}

// class Drive {
//   String id;
//   String role;
//   Company company;
//   int createdOn;
//   String jobType;
//   String jd;
//   int ctc;
//   DateTime regitrationDeadline;
//   Eligibility eligibility;
//   int noOfPositions;
//   bool bondApplicable;
//   String location;
//   String venue;
//   String? additionalInfo;
//   bool locked;
//   int maxApplications;
//   bool openForAll;
//   String createdBy;
//   List<String> department;
//   List<dynamic> files;
//   List<String> roleFuzzy;
//   String slug;
//   int v;
//   List<dynamic>? additionalQuestions;

//   Drive({
//     required this.id,
//     required this.role,
//     required this.company,
//     required this.createdOn,
//     required this.jobType,
//     required this.jd,
//     required this.ctc,
//     required this.regitrationDeadline,
//     required this.eligibility,
//     required this.noOfPositions,
//     required this.bondApplicable,
//     required this.location,
//     required this.venue,
//     this.additionalInfo,
//     required this.locked,
//     required this.maxApplications,
//     required this.openForAll,
//     required this.createdBy,
//     required this.department,
//     required this.files,
//     required this.roleFuzzy,
//     required this.slug,
//     required this.v,
//     this.additionalQuestions,
//   });

//   factory Drive.fromJson(Map<String, dynamic> json) => Drive(
//         id: json["_id"],
//         role: json["role"],
//         company: Company.fromJson(json["company"]),
//         createdOn: json["createdOn"],
//         jobType: json["jobType"],
//         jd: json["jd"],
//         ctc: json["ctc"],
//         regitrationDeadline: DateTime.parse(json["regitrationDeadline"]),
//         eligibility: Eligibility.fromJson(json["eligibility"]),
//         noOfPositions: json["noOfPositions"],
//         bondApplicable: json["bondApplicable"],
//         location: json["location"],
//         venue: json["venue"],
//         additionalInfo: json["additionalInfo"],
//         locked: json["locked"],
//         maxApplications: json["maxApplications"],
//         openForAll: json["openForAll"],
//         createdBy: json["createdBy"],
//         department: List<String>.from(json["department"].map((x) => x)),
//         files: List<dynamic>.from(json["files"].map((x) => x)),
//         roleFuzzy: List<String>.from(json["role_fuzzy"].map((x) => x)),
//         slug: json["slug"],
//         v: json["__v"],
//         additionalQuestions: json["additionalQuestions"] == null
//             ? []
//             : List<dynamic>.from(json["additionalQuestions"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "role": role,
//         "company": company.toJson(),
//         "createdOn": createdOn,
//         "jobType": jobType,
//         "jd": jd,
//         "ctc": ctc,
//         "regitrationDeadline": regitrationDeadline.toIso8601String(),
//         "eligibility": eligibility.toJson(),
//         "noOfPositions": noOfPositions,
//         "bondApplicable": bondApplicable,
//         "location": location,
//         "venue": venue,
//         "additionalInfo": additionalInfo,
//         "locked": locked,
//         "maxApplications": maxApplications,
//         "openForAll": openForAll,
//         "createdBy": createdBy,
//         "department": List<dynamic>.from(department.map((x) => x)),
//         "files": List<dynamic>.from(files.map((x) => x)),
//         "role_fuzzy": List<dynamic>.from(roleFuzzy.map((x) => x)),
//         "slug": slug,
//         "__v": v,
//         "additionalQuestions": additionalQuestions == null
//             ? []
//             : List<dynamic>.from(additionalQuestions!.map((x) => x)),
//       };
// }

class Company {
  String id;
  String name;
  int createdOn;
  dynamic externalId;
  List<dynamic> reviews;
  List<dynamic> questions;
  bool processed;
  String logoUrl;
  String website;
  List<String> nameFuzzy;
  String slug;
  int v;
  String? description;

  Company({
    required this.id,
    required this.name,
    required this.createdOn,
    this.externalId,
    required this.reviews,
    required this.questions,
    required this.processed,
    required this.logoUrl,
    required this.website,
    required this.nameFuzzy,
    required this.slug,
    required this.v,
    this.description,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["_id"],
        name: json["name"],
        createdOn: json["createdOn"],
        externalId: json["external_id"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        questions: List<dynamic>.from(json["questions"].map((x) => x)),
        processed: json["processed"],
        logoUrl: json["logoUrl"],
        website: json["website"],
        nameFuzzy: List<String>.from(json["name_fuzzy"].map((x) => x)),
        slug: json["slug"],
        v: json["__v"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdOn": createdOn,
        "external_id": externalId,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "processed": processed,
        "logoUrl": logoUrl,
        "website": website,
        "name_fuzzy": List<dynamic>.from(nameFuzzy.map((x) => x)),
        "slug": slug,
        "__v": v,
        "description": description,
      };
}

class Eligibility {
  int? tenthPercentage;
  double? graduationPercentage;
  List<dynamic> skills;
  List<dynamic> softSkills;
  List<dynamic> languages;

  Eligibility({
    this.tenthPercentage,
    this.graduationPercentage,
    required this.skills,
    required this.softSkills,
    required this.languages,
  });

  factory Eligibility.fromJson(Map<String, dynamic> json) => Eligibility(
        tenthPercentage: json["tenthPercentage"],
        graduationPercentage: json["graduationPercentage"]?.toDouble(),
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
        softSkills: List<dynamic>.from(json["softSkills"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tenthPercentage": tenthPercentage,
        "graduationPercentage": graduationPercentage,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "softSkills": List<dynamic>.from(softSkills.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
      };
}
