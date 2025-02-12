// To parse this JSON data, do
//
//     final drive = driveFromJson(jsonString);

import 'dart:convert';

List<Drive> driveListFromJson(String str) =>
    List<Drive>.from(json.decode(str).map((x) => Drive.fromJson(x)));

String driveToJson(List<Drive> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//drive from json

Drive driveFromJson(String str) => Drive.fromJson(json.decode(str));

class Drive {
  Drive({
    required this.id,
    required this.role,
    required this.company,
    required this.createdOn,
    required this.jobType,
    required this.jd,
    required this.ctc,
    required this.regitrationDeadline,
    required this.eligibility,
    required this.noOfPositions,
    required this.bondApplicable,
    required this.location,
    required this.venue,
    required this.locked,
    this.maxApplications,
    this.openForAll,
    // required this.createdBy,
    required this.department,
    this.files,
    required this.roleFuzzy,
    this.additionalQuestions,
    required this.slug,
    required this.v,
    required this.bookmarked,
    required this.applied,
    required this.calculatedEligibility,
    this.bondDuration,
    this.bondStatement,
    this.additionalInfo,
    this.applicationId,
  });

  String id;
  String role;
  Company company;
  int createdOn;
  JobType jobType;
  String jd;
  int ctc;
  DateTime regitrationDeadline;
  Eligibility? eligibility;
  int noOfPositions;
  bool? bondApplicable;
  String location;
  String venue;
  bool locked;
  int? maxApplications;
  bool? openForAll;
  // CreatedBy createdBy;
  List<String> department;
  List<FileElement>? files;
  List<String> roleFuzzy;
  List<AdditionalQuestion>? additionalQuestions;
  String slug;
  int v;
  bool? bookmarked;
  bool? applied;
  CalculatedEligibility? calculatedEligibility;
  int? bondDuration;
  String? bondStatement;
  String? additionalInfo;
  String? applicationId;

  factory Drive.fromJson(Map<String, dynamic> json) => Drive(
        id: json["_id"],
        role: json["role"],
        company: Company.fromJson(json["company"]),
        createdOn: json["createdOn"],
        jobType: jobTypeValues.map[json["jobType"]] ?? JobType.fulltime,
        jd: json["jd"],
        ctc: json["ctc"],
        regitrationDeadline: DateTime.parse(json["regitrationDeadline"]),
        eligibility: Eligibility.fromJson(json["eligibility"]),
        noOfPositions: json["noOfPositions"],
        bondApplicable: json["bondApplicable"],
        location: json["location"],
        venue: json["venue"],
        locked: json["locked"],
        maxApplications: json["maxApplications"],
        openForAll: json["openForAll"],
        // createdBy: createdByValues.map[json["createdBy"]]!,
        department: List<String>.from(json["department"].map((x) => x)),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
        roleFuzzy: List<String>.from(json["role_fuzzy"].map((x) => x)),
        additionalQuestions: json["additionalQuestions"] == null
            ? []
            : List<AdditionalQuestion>.from(json["additionalQuestions"]!
                .map((x) => AdditionalQuestion.fromJson(x))),
        slug: json["slug"],
        v: json["__v"],
        bookmarked: json["bookmarked"],
        applied: json["applied"],
        calculatedEligibility: json["calculatedEligibility"] == null
            ? null
            : CalculatedEligibility.fromJson(json["calculatedEligibility"]),
        bondDuration: json["bondDuration"],
        bondStatement: json["bondStatement"],
        additionalInfo: json["additionalInfo"],
        applicationId: json["applicationId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "company": company.toJson(),
        "createdOn": createdOn,
        "jobType": jobTypeValues.reverse[jobType],
        "jd": jd,
        "ctc": ctc,
        "regitrationDeadline": regitrationDeadline.toIso8601String(),
        "eligibility": eligibility?.toJson(),
        "noOfPositions": noOfPositions,
        "bondApplicable": bondApplicable,
        "location": location,
        "venue": venue,
        "locked": locked,
        "maxApplications": maxApplications,
        "openForAll": openForAll,
        // "createdBy": createdByValues.reverse[createdBy],
        "department": List<dynamic>.from(department.map((x) => x)),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "role_fuzzy": List<dynamic>.from(roleFuzzy.map((x) => x)),
        "additionalQuestions": additionalQuestions == null
            ? []
            : List<dynamic>.from(additionalQuestions!.map((x) => x.toJson())),
        "slug": slug,
        "__v": v,
        "bookmarked": bookmarked,
        "applied": applied,
        "calculatedEligibility": calculatedEligibility?.toJson(),
        "bondDuration": bondDuration,
        "bondStatement": bondStatement,
        "additionalInfo": additionalInfo,
        "applicationId": applicationId,
      };
}

// enum AdditionalInfo { ADDITIONAL_INFO, APPLICANTS_MUST_BE_ATTENTIVE_AND_SMART }

// final additionalInfoValues = EnumValues({
//     "Additional Info": AdditionalInfo.ADDITIONAL_INFO,
//     "Applicants must be attentive and smart": AdditionalInfo.APPLICANTS_MUST_BE_ATTENTIVE_AND_SMART
// });

class AdditionalQuestion {
  AdditionalQuestion({
    required this.question,
    required this.type,
    required this.options,
    required this.required,
    required this.multiSelect,
    required this.id,
  });

  String question;
  String type;
  List<Option> options;
  bool required;
  bool multiSelect;
  String id;

  factory AdditionalQuestion.fromJson(Map<String, dynamic> json) =>
      AdditionalQuestion(
        question: json["question"],
        type: json["type"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        required: json["required"],
        multiSelect: json["multiSelect"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "type": type,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "required": required,
        "multiSelect": multiSelect,
        "_id": id,
      };
}

class Option {
  Option({
    required this.text,
    required this.id,
  });

  String text;
  String id;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        text: json["text"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "_id": id,
      };
}

class CalculatedEligibility {
  CalculatedEligibility({
    required this.eligibilityList,
    required this.eligible,
  });

  List<EligibilityList> eligibilityList;
  bool eligible;

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
  EligibilityList({
    required this.pass,
    required this.reason,
  });

  bool pass;
  String reason;

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

class Company {
  Company({
    required this.id,
    required this.name,
    required this.createdOn,
    this.externalId,
    required this.reviews,
    required this.questions,
    required this.processed,
    required this.logoUrl,
    required this.nameFuzzy,
    required this.slug,
    required this.v,
    this.website,
    this.description,
  });

  String id;
  String name;
  int createdOn;
  String? externalId;
  List<dynamic> reviews;
  List<dynamic> questions;
  bool processed;
  String logoUrl;
  List<String> nameFuzzy;
  String slug;
  int v;
  String? website;
  String? description;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["_id"],
        name: json["name"],
        createdOn: json["createdOn"],
        externalId: json["external_id"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        questions: List<dynamic>.from(json["questions"].map((x) => x)),
        processed: json["processed"],
        logoUrl: json["logoUrl"],
        nameFuzzy: List<String>.from(json["name_fuzzy"].map((x) => x)),
        slug: json["slug"],
        v: json["__v"],
        website: json["website"],
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
        "name_fuzzy": List<dynamic>.from(nameFuzzy.map((x) => x)),
        "slug": slug,
        "__v": v,
        "website": website,
        "description": description,
      };
}

// enum CreatedBy { PBUR_SZVO_SV_NAOW_SPH_C_WB_H_BPRF_WI3 }

// final createdByValues = EnumValues({
//     "PburSZVOSvNAOWSphCWbHBprfWI3": CreatedBy.PBUR_SZVO_SV_NAOW_SPH_C_WB_H_BPRF_WI3
// });

// enum Department { BEIS }

// final departmentValues = EnumValues({"BEIS": Department.BEIS});

class Eligibility {
  Eligibility({
    this.tenthPercentage,
    this.twelfthPercentage,
    this.graduationPercentage,
    required this.skills,
    required this.softSkills,
    required this.languages,
    this.age,
    this.internshipCount,
    this.projectCount,
    this.certificationCount,
    this.achievementCount,
  });

  int? tenthPercentage;
  int? twelfthPercentage;
  double? graduationPercentage;
  List<Language> skills;
  List<Language> softSkills;
  List<Language> languages;
  int? age;
  int? internshipCount;
  int? projectCount;
  int? certificationCount;
  int? achievementCount;

  factory Eligibility.fromJson(Map<String, dynamic> json) => Eligibility(
        tenthPercentage: json["tenthPercentage"],
        twelfthPercentage: json["twelfthPercentage"],
        graduationPercentage: json["graduationPercentage"]?.toDouble(),
        skills: List<Language>.from(
            json["skills"].map((x) => Language.fromJson(x))),
        softSkills: List<Language>.from(
            json["softSkills"].map((x) => Language.fromJson(x))),
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        age: json["age"],
        internshipCount: json["internshipCount"],
        projectCount: json["projectCount"],
        certificationCount: json["certificationCount"],
        achievementCount: json["achievementCount"],
      );

  Map<String, dynamic> toJson() => {
        "tenthPercentage": tenthPercentage,
        "twelfthPercentage": twelfthPercentage,
        "graduationPercentage": graduationPercentage,
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
        "softSkills": List<dynamic>.from(softSkills.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
        "age": age,
        "internshipCount": internshipCount,
        "projectCount": projectCount,
        "certificationCount": certificationCount,
        "achievementCount": achievementCount,
      };
}

class Language {
  Language({
    required this.id,
    required this.name,
    required this.nameFuzzy,
    required this.v,
  });

  String id;
  String name;
  List<String> nameFuzzy;
  int v;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["_id"],
        name: json["name"],
        nameFuzzy: List<String>.from(json["name_fuzzy"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "name_fuzzy": List<dynamic>.from(nameFuzzy.map((x) => x)),
        "__v": v,
      };
}

class FileElement {
  FileElement({
    required this.id,
    required this.key,
    required this.v,
    required this.bucket,
    required this.contentType,
    required this.createdOn,
    required this.location,
    required this.scope,
    required this.size,
  });

  String id;
  String key;
  int v;
  String bucket;
  String contentType;
  int createdOn;
  String location;
  String scope;
  int size;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["_id"],
        key: json["key"],
        v: json["__v"],
        bucket: json["bucket"],
        contentType: json["contentType"],
        createdOn: json["createdOn"],
        location: json["location"],
        scope: json["scope"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "key": key,
        "__v": v,
        "bucket": bucket,
        "contentType": contentType,
        "createdOn": createdOn,
        "location": location,
        "scope": scope,
        "size": size,
      };
}

enum JobType { fulltime, internship }

final jobTypeValues = EnumValues(
    {"full-time": JobType.fulltime, "internship": JobType.internship});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
