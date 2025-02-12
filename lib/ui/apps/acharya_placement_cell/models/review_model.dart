// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  bool success;
  Data data;

  Review({
    required this.success,
    required this.data,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  List<DriveData> drives;
  Company company;

  Data({
    required this.drives,
    required this.company,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        drives: List<DriveData>.from(
            json["drives"].map((x) => DriveData.fromJson(x))),
        company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "drives": List<dynamic>.from(drives.map((x) => x.toJson())),
        "company": company.toJson(),
      };
}

class Company {
  String id;
  String name;
  int createdOn;
  String externalId;
  List<String>? reviews;
  List<String>? questions;
  bool processed;
  double? rating;
  String logoUrl;
  List<String>? pros;
  List<String>? cons;
  String slug;
  int v;
  List<String>? nameFuzzy;

  Company({
    required this.id,
    required this.name,
    required this.createdOn,
    required this.externalId,
    required this.reviews,
    required this.questions,
    required this.processed,
    required this.rating,
    required this.logoUrl,
    required this.pros,
    required this.cons,
    required this.slug,
    required this.v,
    this.nameFuzzy,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["_id"],
        name: json["name"],
        createdOn: json["createdOn"],
        externalId: json["external_id"] ?? '',
        reviews: List<String>.from(json["reviews"].map((x) => x)),
        questions: List<String>.from(json["questions"].map((x) => x)),
        processed: json["processed"],
        rating: json["rating"],
        logoUrl: json["logoUrl"],
        pros: json["pros"] == null
            ? []
            : List<String>.from(json["pros"].map((x) => x)),
        cons: json["cons"] == null
            ? []
            : List<String>.from(json["cons"].map((x) => x)),
        slug: json["slug"],
        v: json["__v"],
        nameFuzzy: json["name_fuzzy"] == null
            ? []
            : List<String>.from(json["name_fuzzy"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdOn": createdOn,
        "external_id": externalId,
        "reviews": List<dynamic>.from(reviews!.map((x) => x)),
        "questions": List<dynamic>.from(questions!.map((x) => x)),
        "processed": processed,
        "rating": rating,
        "logoUrl": logoUrl,
        "pros": List<dynamic>.from(pros!.map((x) => x)),
        "cons": List<dynamic>.from(cons!.map((x) => x)),
        "slug": slug,
        "__v": v,
        "name_fuzzy": nameFuzzy == null
            ? []
            : List<dynamic>.from(nameFuzzy!.map((x) => x)),
      };
}

class DriveData {
  String id;
  String role;
  Company company;
  int createdOn;
  String jobType;
  String jd;
  int ctc;
  String regitrationDeadline;
  // Eligibility eligibility;
  int noOfPositions;
  bool bondApplicable;
  String location;
  String venue;
  bool locked;
  int maxApplications;
  bool openForAll;
  String createdBy;
  List<String> department;
  List<dynamic> files;
  List<String> roleFuzzy;
  List<dynamic> additionalQuestions;
  String slug;
  int v;
  CalculatedEligibility? calculatedEligibility;
  bool applied;
  String applicationId;

  DriveData({
    required this.id,
    required this.role,
    required this.company,
    required this.createdOn,
    required this.jobType,
    required this.jd,
    required this.ctc,
    required this.regitrationDeadline,
    // required this.eligibility,
    required this.noOfPositions,
    required this.bondApplicable,
    required this.location,
    required this.venue,
    required this.locked,
    required this.maxApplications,
    required this.openForAll,
    required this.createdBy,
    required this.department,
    required this.files,
    required this.roleFuzzy,
    required this.additionalQuestions,
    required this.slug,
    required this.v,
    required this.calculatedEligibility,
    required this.applied,
    required this.applicationId,
  });

  factory DriveData.fromJson(Map<String, dynamic> json) => DriveData(
        id: json["_id"],
        role: json["role"],
        company: Company.fromJson(json["company"]),
        createdOn: json["createdOn"],
        jobType: json["jobType"],
        jd: json["jd"],
        ctc: json["ctc"],
        regitrationDeadline: json["regitrationDeadline"],
        // eligibility: Eligibility.fromJson(json["eligibility"]),
        noOfPositions: json["noOfPositions"],
        bondApplicable: json["bondApplicable"],
        location: json["location"],
        venue: json["venue"],
        locked: json["locked"],
        maxApplications: json["maxApplications"] ?? 0,
        openForAll: json["openForAll"] ?? false,
        createdBy: json["createdBy"],
        department: List<String>.from(json["department"].map((x) => x)),
        files: json["files"] == null
            ? []
            : List<dynamic>.from(json["files"].map((x) => x)),
        roleFuzzy: json["role_fuzzy"] == null
            ? []
            : List<String>.from(json["role_fuzzy"].map((x) => x)),
        additionalQuestions: json["additionalQuestions"] == null
            ? []
            : List<dynamic>.from(json["additionalQuestions"].map((x) => x)),
        slug: json["slug"],
        v: json["__v"],
        calculatedEligibility: json["calculatedEligibility"] == null
            ? null
            : CalculatedEligibility.fromJson(json["calculatedEligibility"]),
        applied: json["applied"],
        applicationId: json["applicationId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "company": company.toJson(),
        "createdOn": createdOn,
        "jobType": jobType,
        "jd": jd,
        "ctc": ctc,
        "regitrationDeadline": regitrationDeadline,
        // "eligibility": eligibility.toJson(),
        "noOfPositions": noOfPositions,
        "bondApplicable": bondApplicable,
        "location": location,
        "venue": venue,
        "locked": locked,
        "maxApplications": maxApplications,
        "openForAll": openForAll,
        "createdBy": createdBy,
        "department": List<dynamic>.from(department.map((x) => x)),
        "files": List<dynamic>.from(files.map((x) => x)),
        "role_fuzzy": List<dynamic>.from(roleFuzzy.map((x) => x)),
        "additionalQuestions":
            List<dynamic>.from(additionalQuestions.map((x) => x)),
        "slug": slug,
        "__v": v,
        "calculatedEligibility": calculatedEligibility!.toJson(),
        "applied": applied,
        "applicationId": applicationId,
      };
}

class CalculatedEligibility {
  List<EligibilityList> eligibilityList;
  bool eligible;

  CalculatedEligibility({
    required this.eligibilityList,
    required this.eligible,
  });

  factory CalculatedEligibility.fromJson(Map<String, dynamic> json) =>
      CalculatedEligibility(
        eligibilityList: List<EligibilityList>.from(
            json["eligibilityList"].map((x) => EligibilityList.fromJson(x))),
        eligible: json["eligible"],
      );

  Map<String, dynamic> toJson() => {
        "eligibilityList":
            List<dynamic>.from(eligibilityList.map((x) => x.toJson())),
        "eligible": eligible,
      };
}

class EligibilityList {
  bool pass;
  String reason;

  EligibilityList({
    required this.pass,
    required this.reason,
  });

  factory EligibilityList.fromJson(Map<String, dynamic> json) =>
      EligibilityList(
        pass: json["pass"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "pass": pass,
        "reason": reason,
      };
}

class Eligibility {
  int tenthPercentage;
  List<dynamic> skills;
  List<dynamic> softSkills;
  List<dynamic> languages;

  Eligibility({
    required this.tenthPercentage,
    required this.skills,
    required this.softSkills,
    required this.languages,
  });

  factory Eligibility.fromJson(Map<String, dynamic> json) => Eligibility(
        tenthPercentage: json["tenthPercentage"],
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
        softSkills: List<dynamic>.from(json["softSkills"].map((x) => x)),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tenthPercentage": tenthPercentage,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "softSkills": List<dynamic>.from(softSkills.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
      };
}
