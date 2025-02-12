// To parse this JSON data, do
//
//     final profileProgressModel = profileProgressModelFromJson(jsonString);

import 'dart:convert';

ProfileProgressModel profileProgressModelFromJson(String str) =>
    ProfileProgressModel.fromJson(json.decode(str));

String profileProgressModelToJson(ProfileProgressModel data) =>
    json.encode(data.toJson());

// final profileModel = profileModelFromJson(jsonString);

Profile profileModelFromJson(String str) => Profile.fromJson(json.decode(str));

class ProfileProgressModel {
  ProfileProgressModel({
    this.profile,
    this.progress,
  });

  Profile? profile;
  Progress? progress;

  factory ProfileProgressModel.fromJson(Map<String, dynamic> json) =>
      ProfileProgressModel(
        profile: Profile.fromJson(json["profile"]),
        progress: Progress.fromJson(json["progress"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile!.toJson(),
        "progress": progress!.toJson(),
      };
}

class Profile {
  Profile({
    this.id,
    this.uid,
    this.v,
    this.achievements,
    this.certifications,
    this.educationDetails,
    this.internshipDetails,
    this.languages,
    this.projects,
    this.skills,
    this.softSkills,
    this.basicDetails,
  });

  String? id;
  String? uid;
  int? v;
  List<Achievement>? achievements;
  List<Certification>? certifications;
  EducationDetails? educationDetails;
  List<InternshipDetail>? internshipDetails;
  List<Skill>? languages;
  List<Project>? projects;
  List<Skill>? skills;
  List<Skill>? softSkills;
  BasicDetails? basicDetails;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        uid: json["uid"],
        v: json["__v"],
        achievements: List<Achievement>.from(
            json["achievements"].map((x) => Achievement.fromJson(x))),
        certifications: List<Certification>.from(
            json["certifications"].map((x) => Certification.fromJson(x))),
        educationDetails: EducationDetails.fromJson(json["educationDetails"]),
        internshipDetails: List<InternshipDetail>.from(
            json["internshipDetails"].map((x) => InternshipDetail.fromJson(x))),
        languages:
            List<Skill>.from(json["languages"].map((x) => Skill.fromJson(x))),
        projects: List<Achievement>.from(
            json["projects"].map((x) => Achievement.fromJson(x))),
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        softSkills:
            List<Skill>.from(json["softSkills"].map((x) => Skill.fromJson(x))),
        basicDetails: BasicDetails.fromJson(json["basicDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "__v": v,
        "achievements":
            List<dynamic>.from(achievements!.map((x) => x.toJson())),
        "certifications":
            List<dynamic>.from(certifications!.map((x) => x.toJson())),
        "educationDetails": educationDetails!.toJson(),
        "internshipDetails":
            List<dynamic>.from(internshipDetails!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "projects": List<dynamic>.from(projects!.map((x) => x.toJson())),
        "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
        "softSkills": List<dynamic>.from(softSkills!.map((x) => x.toJson())),
        "basicDetails": basicDetails!.toJson(),
      };
}

// use class name Achievement for both achievements and projects

typedef Project = Achievement;
typedef Certification = Achievement;

class Achievement {
  Achievement({
    this.title,
    this.description,
    this.link,
    this.organization,
    this.id,
  });

  String? title;
  String? description;
  String? link;
  String? organization;
  String? id;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        title: json["title"] ?? json["name"],
        description: json["description"],
        link: json["link"] ?? json["certificateLink"],
        organization: json["organization"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "link": link,
        "organization": organization,
        "_id": id,
      };
}

class BasicDetails {
  BasicDetails({
    this.photoUrl,
    this.phone,
    this.gender,
    this.usn,
    this.dob,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.createdOn,
    this.blacklisted,
    this.uid,
    this.role,
    this.studentMeta,
    this.createdBy,
    this.slug,
    this.v,
  });

  String? photoUrl;
  String? phone;
  String? gender;
  String? usn;
  DateTime? dob;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? createdOn;
  bool? blacklisted;
  String? uid;
  String? role;
  StudentMeta? studentMeta;
  String? createdBy;
  String? slug;
  int? v;

  factory BasicDetails.fromJson(Map<String, dynamic> json) => BasicDetails(
        photoUrl: json["photoUrl"],
        phone: json["phone"],
        gender: json["gender"],
        usn: json["usn"],
        dob: DateTime.parse(json["dob"]),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        createdOn: json["createdOn"],
        blacklisted: json["blacklisted"],
        uid: json["uid"],
        role: json["role"],
        studentMeta: StudentMeta.fromJson(json["studentMeta"]),
        createdBy: json["created_by"],
        slug: json["slug"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        // "photoUrl": photoUrl,
        "phone": phone,
        "gender": gender,
        // "usn": usn,
        "dob": dob!.toIso8601String(),
        // "_id": id,
        // "firstName": firstName,
        // "lastName": lastName,
        // "email": email,
        // "createdOn": createdOn,
        // "blacklisted": blacklisted,
        // "uid": uid,
        // "role": role,
        // "studentMeta": studentMeta!.toJson(),
        // "created_by": createdBy,
        // "slug": slug,
        // "__v": v,
      };
}

class StudentMeta {
  StudentMeta({
    this.department,
    this.year,
    this.placed,
  });

  String? department;
  int? year;
  bool? placed;

  factory StudentMeta.fromJson(Map<String, dynamic> json) => StudentMeta(
        department: json["department"],
        year: json["year"],
        placed: json["placed"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "year": year,
        "placed": placed,
      };
}

typedef Tenth = Degree;
typedef Twelfth = Degree;
typedef UG = Degree;

class EducationDetails {
  EducationDetails({
    this.tenth,
    this.twelfth,
    this.ug,
  });

  Tenth? tenth;
  Twelfth? twelfth;
  UG? ug;

  factory EducationDetails.fromJson(Map<String, dynamic> json) =>
      EducationDetails(
        tenth: Degree.fromJson(json["tenth"]),
        twelfth: Degree.fromJson(json["twelfth"]),
        ug: Degree.fromJson(json["ug"]),
      );

  Map<String, dynamic> toJson() => {
        "tenth": tenth!.toJson(),
        "twelfth": twelfth!.toJson(),
        "ug": ug!.toJson(),
      };
}

class Degree {
  Degree({
    this.institution,
    this.startYear,
    this.endYear,
    this.gradeScale,
    this.grade,
    // this.id,
  });

  String? institution;
  int? startYear;
  int? endYear;
  int? gradeScale;
  double? grade;
  // String? id;

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
        institution: json["institution"],
        startYear: json["startYear"],
        endYear: json["endYear"],
        gradeScale: json["gradeScale"],
        grade: json["grade"].toDouble(),
        // id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "institution": institution,
        "startYear": startYear,
        "endYear": endYear,
        "gradeScale": gradeScale,
        "grade": grade,
        // "_id": id,
      };
}

List<InternshipDetail> internshipDetailFromJson(String str) =>
    List<InternshipDetail>.from(
        json.decode(str).map((x) => InternshipDetail.fromJson(x)));

class InternshipDetail {
  InternshipDetail({
    this.companyName,
    this.startMonth,
    this.startYear,
    this.endMonth,
    this.endYear,
    this.role,
    this.description,
    this.ongoing,
    this.id,
  });

  String? companyName;
  String? startMonth;
  int? startYear;
  String? endMonth;
  int? endYear;
  String? role;
  String? description;
  bool? ongoing;
  String? id;

  factory InternshipDetail.fromJson(Map<String, dynamic> json) =>
      InternshipDetail(
        companyName: json["companyName"],
        startMonth: json["startMonth"],
        startYear: json["startYear"],
        endMonth: json["endMonth"],
        endYear: json["endYear"],
        role: json["role"],
        description: json["description"],
        ongoing: json["ongoing"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "startMonth": startMonth,
        "startYear": startYear,
        "endMonth": endMonth,
        "endYear": endYear,
        "role": role,
        "description": description,
        "ongoing": ongoing,
        "_id": id,
      };
}

List<Skill> skillFromJson(String str) =>
    List<Skill>.from(json.decode(str).map((x) => Skill.fromJson(x)));

class Skill {
  Skill({
    this.id,
    this.name,
  });
  @override
  String toString() {
    return name!;
  }

  String getId() {
    return id!;
  }

  String? id;
  String? name;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Progress {
  Progress({
    this.steps,
    this.goToStep,
    this.completedPercentage,
    this.completed,
  });

  Steps? steps;
  String? goToStep;
  int? completedPercentage;
  bool? completed;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        steps: Steps.fromJson(json["steps"]),
        goToStep: json["goToStep"],
        completedPercentage: json["completedPercentage"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps!.toJson(),
        "goToStep": goToStep,
        "completedPercentage": completedPercentage,
        "completed": completed,
      };
}

class Steps {
  Steps({
    this.basicDetails,
    this.educationDetails,
    this.skills,
    this.softSkills,
    this.internshipDetails,
    this.projects,
    this.certifications,
    this.achievements,
    this.languages,
  });

  bool? basicDetails;
  bool? educationDetails;
  bool? skills;
  bool? softSkills;
  bool? internshipDetails;
  bool? projects;
  bool? certifications;
  bool? achievements;
  bool? languages;

  factory Steps.fromJson(Map<String, dynamic> json) => Steps(
        basicDetails: json["basicDetails"],
        educationDetails: json["educationDetails"],
        skills: json["skills"],
        softSkills: json["softSkills"],
        internshipDetails: json["internshipDetails"],
        projects: json["projects"],
        certifications: json["certifications"],
        achievements: json["achievements"],
        languages: json["languages"],
      );

  Map<String, dynamic> toJson() => {
        "basicDetails": basicDetails,
        "educationDetails": educationDetails,
        "skills": skills,
        "softSkills": softSkills,
        "internshipDetails": internshipDetails,
        "projects": projects,
        "certifications": certifications,
        "achievements": achievements,
        "languages": languages,
      };
}
