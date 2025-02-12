import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/announcement_model.dart';
import '../models/applied_model.dart';
import '../models/drive_model.dart';
import '../models/main_model.dart';
import '../models/review_model.dart';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'https://placementdevapi.techstax.co/api';

  static Future<ProfileProgressModel?> getStudentProgress() async {
    log('getStudentProfileProgress');
    Uri url = Uri.parse('$baseUrl/student/profile/progress');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      var data = json.encode(responseJson['data']);

      final profileProgressModel = profileProgressModelFromJson(data);

      return profileProgressModel;
    } else {
      log('Failed to load profile');
    }
    return null;
  }

  static Future<Profile?> getStudentProfile() async {
    log('getStudentProfile');
    Uri url = Uri.parse('$baseUrl/student/profile');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      var data = json.encode(responseJson['data']['profile']);
      final profileModel = profileModelFromJson(data);
      return profileModel;
    } else {
      log('Failed to load profile');
    }
    return null;
  }

  static Future<String?> updateStudentProfileBasic(
      {required BasicDetails studentBasicDetails}) async {
    log('updateStudentProfileBasic');
    Uri url = Uri.parse('$baseUrl/student/profile/basic');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{'Authorization': token},
      body: studentBasicDetails.toJson(),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Profile updated successfully');
      return 'Success';
    } else {
      log('Failed to update profile');
    }
    return null;
  }

  static Future<String?> updateStudentProfileEducation(
      {required Degree studentEducationDetails,
      required String education}) async {
    log('updateStudentProfileEducation');

    Uri url = Uri.parse('$baseUrl/student/profile/education/$education');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        "content-type": "application/json",
        'Authorization': token,
      },
      body: jsonEncode({
        "institution": studentEducationDetails.institution,
        "startYear": studentEducationDetails.startYear,
        "endYear": studentEducationDetails.endYear,
        "gradeScale": studentEducationDetails.gradeScale,
        "grade": studentEducationDetails.grade
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Education updated successfully');
      return 'Success';
    } else {
      log('Failed to update education');
    }
    return null;
  }

  static Future<List<Skill>?> searchSkills(
      String skill, String skillType) async {
    log('searchSkills');
    Uri url = Uri.parse(
        '$baseUrl/student/profile/${skillType.toLowerCase()}/search?q=$skill');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      var data = json.encode(responseJson['data'][skillType]);
      final skillsModel = skillFromJson(data);
      return skillsModel;
    } else {
      log('Failed to search skills');
    }
    return null;
  }

  static Future<List<Skill>?> getStudentProfileSkills(
      {required String skillType}) async {
    log('getStudentProfileSkills');
    Uri url = Uri.parse('$baseUrl/student/profile/$skillType');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      var data = json.encode(responseJson['data']['skills']);
      final skillsModel = skillFromJson(data);
      return skillsModel;
    } else {
      log('Failed to load skills');
    }
    return null;
  }

  static Future<String?> updateStudentProfileSkills(
      {required List<String> studentSkills, required String skillType}) async {
    log('updateStudentProfileSkills');
    Uri url = Uri.parse('$baseUrl/student/profile/$skillType');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        "content-type": "application/json",
        'Authorization': token,
      },
      body: jsonEncode({skillType: studentSkills}),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Skills updated successfully');
      return 'Success';
    } else {
      log('Failed to update skills');
    }
    return null;
  }

  static Future<String?> updateStudentProfileInternships(
      {required InternshipDetail studentInternshipDetails}) async {
    log('updateStudentProfileInternships');
    Uri url = Uri.parse('$baseUrl/student/profile/internships');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "companyName": studentInternshipDetails.companyName,
        "startMonth":
            studentInternshipDetails.startMonth!.toLowerCase().substring(0, 3),
        "startYear": studentInternshipDetails.startYear,
        "endMonth":
            studentInternshipDetails.endMonth?.toLowerCase().substring(0, 3),
        "endYear": studentInternshipDetails.endYear,
        "ongoing": studentInternshipDetails.ongoing,
        "role": studentInternshipDetails.role,
        "description": studentInternshipDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Internship updated successfully');
      return 'Success';
    } else {
      log('Failed to update internship');
    }
    return null;
  }

  static Future<String?> updateStudentProfileInternshipsById(
      {required InternshipDetail studentInternshipDetails,
      required String internshipId}) async {
    log('updateStudentProfileInternshipsById');
    Uri url = Uri.parse('$baseUrl/student/profile/internships/$internshipId');
    final String token = await AuthService.getToken();
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "companyName": studentInternshipDetails.companyName,
        "startMonth":
            studentInternshipDetails.startMonth!.toLowerCase().substring(0, 3),
        "startYear": studentInternshipDetails.startYear,
        "endMonth":
            studentInternshipDetails.endMonth?.toLowerCase().substring(0, 3),
        "endYear": studentInternshipDetails.endYear,
        "ongoing": studentInternshipDetails.ongoing,
        "role": studentInternshipDetails.role,
        "description": studentInternshipDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Internship updated successfully');
      return 'Success';
    } else {
      log('Failed to update internship');
    }
    return null;
  }

  static Future<String?> deleteStudentProfileInternshipsById(
      {required String internshipId}) async {
    log('deleteStudentProfileInternshipsById');
    Uri url = Uri.parse('$baseUrl/student/profile/internships/$internshipId');
    final String token = await AuthService.getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Internship deleted successfully');
      return 'Success';
    } else {
      log('Failed to delete internship');
    }
    return null;
  }

  static Future<String?> updateStudentProfileProjects(
      {required Project studentProjectDetails}) async {
    log('updateStudentProfileProjects');
    Uri url = Uri.parse('$baseUrl/student/profile/projects');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "title": studentProjectDetails.title,
        "link": studentProjectDetails.link,
        "description": studentProjectDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Project updated successfully');
      return 'Success';
    } else {
      log('Failed to update project');
    }
    return null;
  }

  static Future<String?> updateStudentProfileProjectsById(
      {required Project studentProjectDetails,
      required String projectId}) async {
    log('updateStudentProfileProjectsById');
    Uri url = Uri.parse('$baseUrl/student/profile/projects/$projectId');
    final String token = await AuthService.getToken();
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "title": studentProjectDetails.title,
        "link": studentProjectDetails.link,
        "description": studentProjectDetails.description
      }),
    );

    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Project updated successfully');
      return 'Success';
    } else {
      log('Failed to update project');
    }
    return null;
  }

  static Future<String?> deleteStudentProfileProjectsById(
      {required String projectId}) async {
    log('deleteStudentProfileProjectsById');
    Uri url = Uri.parse('$baseUrl/student/profile/projects/$projectId');
    final String token = await AuthService.getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Project deleted successfully');
      return 'Success';
    } else {
      log('Failed to delete project');
    }
    return null;
  }

  static Future<String?> updateStudentProfileCertifications(
      {required Certification studentCertificationDetails}) async {
    log('updateStudentProfileCertifications');
    Uri url = Uri.parse('$baseUrl/student/profile/certifications');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "organization": studentCertificationDetails.organization,
        "name": studentCertificationDetails.title,
        "certificateLink": studentCertificationDetails.link,
        "description": studentCertificationDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Certification updated successfully');
      return 'Success';
    } else {
      log('Failed to update certification');
    }
    return null;
  }

  static Future<String?> updateStudentProfileCertificationsById(
      {required Certification studentCertificationDetails,
      required String certificationId}) async {
    log('updateStudentProfileCertificationsById');
    Uri url =
        Uri.parse('$baseUrl/student/profile/certifications/$certificationId');
    final String token = await AuthService.getToken();
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "organization": studentCertificationDetails.organization,
        "name": studentCertificationDetails.title,
        "certificateLink": studentCertificationDetails.link,
        "description": studentCertificationDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Certification updated successfully');
      return 'Success';
    } else {
      log('Failed to update certification');
    }
    return null;
  }

  static Future<String?> deleteStudentProfileCertificationsById(
      {required String certificationId}) async {
    log('deleteStudentProfileCertificationsById');
    Uri url =
        Uri.parse('$baseUrl/student/profile/certifications/$certificationId');
    final String token = await AuthService.getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Certification deleted successfully');
      return 'Success';
    } else {
      log('Failed to delete certification');
    }
    return null;
  }

  static Future<String?> updateStudentProfileAchievements(
      {required Achievement studentAchievementDetails}) async {
    log('updateStudentProfileAchievements');
    Uri url = Uri.parse('$baseUrl/student/profile/achievements');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "organization": studentAchievementDetails.organization,
        "title": studentAchievementDetails.title,
        "link": studentAchievementDetails.link,
        "description": studentAchievementDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Achievement updated successfully');
      return 'Success';
    } else {
      log('Failed to update achievement');
    }
    return null;
  }

  static Future<String?> updateStudentProfileAchievementsById(
      {required Achievement studentAchievementDetails,
      required String achievementId}) async {
    log('updateStudentProfileAchievementsById');
    Uri url = Uri.parse('$baseUrl/student/profile/achievements/$achievementId');
    final String token = await AuthService.getToken();
    final response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        "organization": studentAchievementDetails.organization,
        "title": studentAchievementDetails.title,
        "link": studentAchievementDetails.link,
        "description": studentAchievementDetails.description
      }),
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Achievement updated successfully');
      return 'Success';
    } else {
      log('Failed to update achievement');
    }
    return null;
  }

  static Future<String?> deleteStudentProfileAchievementsById(
      {required String achievementId}) async {
    log('deleteStudentProfileAchievementsById');
    Uri url = Uri.parse('$baseUrl/student/profile/achievements/$achievementId');
    final String token = await AuthService.getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Achievement deleted successfully');
      return 'Success';
    } else {
      log('Failed to delete achievement');
    }
    return null;
  }

  static Future<List<Drive>?> getAllDrives() async {
    log('getAllDrives');
    Uri url = Uri.parse('$baseUrl/student/drives/all');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Drives fetched successfully');
      var jsonString = json.encode(responseJson['data']['drives']);
      final drive = driveListFromJson(jsonString);
      return drive;
    } else {
      log('Failed to fetch drives');
    }
    return null;
  }

  static Future<Drive?> getDriveById({required String driveId}) async {
    log('getDriveById');
    Uri url = Uri.parse('$baseUrl/student/drives/$driveId');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Drive fetched successfully');
      var jsonString = json.encode(responseJson['data']['drive']);
      final drive = driveFromJson(jsonString);
      return drive;
    } else {
      log('Failed to fetch drive');
    }
    return null;
  }

  static Future<bool> applyForDrive({required String driveId}) async {
    log('applyForDrive');
    Uri url = Uri.parse('$baseUrl/student/drives/$driveId/apply');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Applied for drive successfully');

      return true;
    } else {
      log('Failed to apply for drive');
      return false;
    }
  }

  static Future<List<Application>?> getAllAppliedDrives() async {
    log('getAllAppliedDrives');
    Uri url = Uri.parse('$baseUrl/student/drives/applied');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Applied drives fetched successfully');
      var jsonString = json.encode(responseJson['data']['applications']);
      final application = applicationFromJson(jsonString);
      return application;
    } else {
      log('Failed to fetch applied drives');
    }
    return null;
  }

  static Future<List<Announcement>?> getAllAnnouncements() async {
    log('getAllAnnouncements');
    Uri url = Uri.parse('$baseUrl/student/drives/announcements/all/sorted');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Announcements fetched successfully');
      var jsonString = json.encode(responseJson['data']['announcements']);
      final announcement = announcementFromJson(jsonString);
      return announcement;
    } else {
      log('Failed to fetch announcements');
    }
    return null;
  }

  static Future<bool> bookmarkDrive({required String driveId}) async {
    log('bookmarkAchievement');
    Uri url = Uri.parse('$baseUrl/student/drives/$driveId/bookmark');
    final String token = await AuthService.getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Achievement bookmarked successfully');

      return true;
    } else {
      log('Failed to bookmark achievement');
      return false;
    }
  }

  static Future<List<Drive>?> getAllBookmarkedDrives() async {
    log('getAllBookmarkedDrives');
    Uri url = Uri.parse('$baseUrl/student/drives/bookmarks');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Bookmarked drives fetched successfully');
      var jsonString = json.encode(responseJson['data']['bookmarks']);
      final drive = driveListFromJson(jsonString);
      return drive;
    } else {
      log('Failed to fetch bookmarked drives');
    }
    return null;
  }

  static Future<Review?> getReviewsByCompany({required String slug}) async {
    log('getReviewsByCompany');
    Uri url = Uri.parse('$baseUrl/student/drives/company/$slug');
    final String token = await AuthService.getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    // log(response.body);
    final responseJson = json.decode(response.body);
    if (responseJson['success']) {
      log('Reviews fetched successfully');
      var jsonString = json.encode(responseJson);
      final review = reviewFromJson(jsonString);
      return review;
    } else {
      log('Failed to fetch reviews');
    }
    return null;
  }

  // static Future<bool> updateMobileToken() async {
  //   log('updateMobileToken');
  //   Uri url = Uri.parse('$baseUrl/student/profile/mobiletoken');
  //   final String token = await AuthService.getToken();
  //   String? fcmToken = await FirebaseMessaging.instance.getToken();

  //   final response = await http.post(
  //     url,
  //     body: jsonEncode({'token': fcmToken!}),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': token,
  //     },
  //   );
  //   // log(response.body);
  //   final responseJson = json.decode(response.body);

  //   if (responseJson['success']) {
  //     log('Mobile token updated successfully');
  //     String topic =
  //         '${responseJson['data']['user']['studentMeta']['year']}_${responseJson['data']['user']['studentMeta']['department'].toString().toLowerCase()}';
  //     log('Subscribing to topic: $topic');
  //     await FirebaseMessaging.instance.subscribeToTopic(topic);
  //     return true;
  //   } else {
  //     log('Failed to update mobile token');
  //     return false;
  //   }
  // }
}

/*
Ashutosh Kumar
{
  "email": "ashutoshv.19.beis@acharya.ac.in",
  "password": "Ashu@1234",  
  "firstName": "Ashutosh",
  "lastName": "Kumar"
}
*/

// "uid": "SUZ9k5ijlOdXogDHM8VsOM7UGLh2",
// "password": "Rwl53qLDgfLY",
// "email": "studenttest10@acharya.ac.in"
