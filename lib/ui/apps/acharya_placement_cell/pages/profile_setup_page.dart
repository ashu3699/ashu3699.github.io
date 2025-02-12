import 'dart:developer';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

import '../constants.dart';
import '../models/main_model.dart';
import '../services/api_service.dart';
import '../utils/string_capitalize.dart';
import '../widgets/mandate_label.dart';
import 'dashboard_page.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  @override
  void initState() {
    super.initState();
    getSkills('html', 'skills');
    getProfileData();
  }

  //profile setup data variables//
  String? _photoUrl;
  Profile profile = Profile();
  BasicDetails basicDetails = BasicDetails();
  EducationDetails educationDetails = EducationDetails();
  Map<String, Skill> industrySkillsMap = {};
  Map<String, Skill> softSkillsMap = {};
  Map<String, Skill> languagesMap = {};
  List<InternshipDetail> internshipsList = [];
  List<Project> projectsList = [];
  List<Certification> certificationsList = [];
  List<Achievement> achievementsList = [];

  Future<void> getProfileData() async {
    setState(() => isLoading = true);
    ProfileProgressModel? res = await ApiService.getStudentProgress();
    if (res != null) {
      if (res.profile != null) {
        profile = res.profile!;
        //if profile setup is complete
        // if (res.progress!.completed!) {
        //   // ignore: use_build_context_synchronously
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const DashboardPage(),
        //     ),
        //   );
        // }

        //profile data
        if (profile.basicDetails != null) {
          basicDetails = profile.basicDetails!;
          //filling the form with data
          {
            _fnameController.text = basicDetails.firstName!;
            _lnameController.text = basicDetails.lastName!;
            _acharyaEmailController.text = basicDetails.email!;
            _usnController.text = basicDetails.usn!.toUpperCase();
            // _personalEmailController.text = basicDetails.personalEmail;
            _phoneController.text = basicDetails.phone!;
            _dobController.text =
                intl.DateFormat('dd-MM-yyyy').format(basicDetails.dob!);
            _selectedGender = basicDetails.gender!.capitalize();
            _photoUrl = basicDetails.photoUrl!;
          }
        }
        //education data
        if (profile.educationDetails != null) {
          educationDetails = profile.educationDetails!;
        }
        //skills data
        if (profile.skills != null) {
          for (var skill in profile.skills!) {
            industrySkillsMap[skill.id!] = skill;
          }
        }
        //soft skills data
        if (profile.softSkills != null) {
          for (var skill in profile.softSkills!) {
            softSkillsMap[skill.id!] = skill;
          }
        }
        //languages data
        if (profile.languages != null) {
          for (var skill in profile.languages!) {
            languagesMap[skill.id!] = skill;
          }
        }
        //internships data
        if (profile.internshipDetails != null) {
          internshipsList = profile.internshipDetails!;
        }
        //projects data
        if (profile.projects != null) {
          projectsList = profile.projects!;
        }
        //certifications data
        if (profile.certifications != null) {
          certificationsList = profile.certifications!;
        }
        //achievements data
        if (profile.achievements != null) {
          achievementsList = profile.achievements!;
        }
      }
    } else {
      setState(() => noData = true);
    }
    setState(() => isLoading = false);
  }

//skill search
  List<Skill> skillsList = [];
  Future<List<Skill>> getSkills(String skill, String skillType) async {
    setState(() => skillsList.clear());
    List<Skill>? res = await ApiService.searchSkills(skill, skillType);
    if (res != null && res.isNotEmpty) {
      setState(() => skillsList = res);
    }
    return skillsList;
  }

  @override
  void dispose() {
    //personal info
    _fnameController.dispose();
    _lnameController.dispose();
    _acharyaEmailController.dispose();
    _usnController.dispose();
    // _personalEmailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();

    //education details
    _institutionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _gradeController.dispose();

    //internship
    _companyNameController.dispose();
    _roleController.dispose();
    _descriptionController.dispose();
    _internStartDateController.dispose();
    _internEndDateController.dispose();

    //project
    _projectTitleController.dispose();
    _projectDescriptionController.dispose();
    _projectLinkController.dispose();

    //certification
    _certificateTitleController.dispose();
    _certificateDescriptionController.dispose();
    _certificateLinkController.dispose();
    _certificateOrganizationController.dispose();

    //achievement
    _achievementTitleController.dispose();
    _achievementDescriptionController.dispose();
    _achievementLinkController.dispose();
    _achievementOrganizationController.dispose();

    super.dispose();
  }

  //text controllers for form fields//

  //personal info
  final _fnameController = TextEditingController(),
      _lnameController = TextEditingController(),
      _acharyaEmailController = TextEditingController(),
      _usnController = TextEditingController(),
      // _personalEmailController = TextEditingController(),
      _phoneController = TextEditingController(),
      _dobController = TextEditingController();

  //education details
  final _institutionController = TextEditingController(),
      _startDateController = TextEditingController(),
      _endDateController = TextEditingController(),
      _gradeController = TextEditingController();

  //internship
  final _companyNameController = TextEditingController(),
      _roleController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _internStartDateController = TextEditingController(),
      _internEndDateController = TextEditingController();

  //project
  final _projectTitleController = TextEditingController(),
      _projectDescriptionController = TextEditingController(),
      _projectLinkController = TextEditingController();

  //certification
  final _certificateTitleController = TextEditingController(),
      _certificateDescriptionController = TextEditingController(),
      _certificateLinkController = TextEditingController(),
      _certificateOrganizationController = TextEditingController();

  //achievement
  final _achievementTitleController = TextEditingController(),
      _achievementDescriptionController = TextEditingController(),
      _achievementLinkController = TextEditingController(),
      _achievementOrganizationController = TextEditingController();

  ///--------------------------------------------------------------///

  //dropdown lists and selected values//

  //personal info
  final _genderList = ['Select Gender', 'Male', 'Female'];
  String _selectedGender = 'Select Gender';
  //education details
  final _classList = ['Select Class', '10th', '12th', 'UG'];
  String _selectedClass = 'Select Class';
  final _gradeScaleList = ['Select Scale', 'CGPA', 'Percentage'];
  String _selectedGradeScale = 'Select Scale';

  int _currentStep = 1;
  bool isLoading = true;
  bool noData = false;
  // bool isCompleted = false;
  bool _ongoing = false;

  final _formKeys = [
    GlobalKey<FormState>(), //0 nothing
    GlobalKey<FormState>(), //1 personal info
    GlobalKey<FormState>(), //2 education details
    GlobalKey<FormState>(), //3 skill set
    GlobalKey<FormState>(), //4 internship experience
    GlobalKey<FormState>(), //5 projects
    GlobalKey<FormState>(), //6 certifications
    GlobalKey<FormState>(), //7 achievements
  ];

  //headings list
  List<String> headings = [
    'Profile Setup', //0 nothing
    'Personal Information', //1
    'Education Details', //2
    'Skill Set', //3
    'Internship Experience', //4
    'Projects', //5
    'Certifications', //6
    'Achievements', //7
  ];

  //body widgets list
  // List<Widget> getBody() => [
  //       buildCompleted(), //0 nothing
  //       personalInfo(), //1
  //       educationalDetails(), //2
  //       skillSet(), //3
  //       internshipExperience(), //4
  //       projects(), //5
  //       certifications(), //6
  //       achievements(), //7
  //     ];

  //switch case for get body
  Widget getBodyWidget(int index) {
    switch (index) {
      case 0:
        return buildCompleted();
      case 1:
        return personalInfo();
      case 2:
        return educationalDetails();
      case 3:
        return skillSet();
      case 4:
        return internshipExperience();
      case 5:
        return projects();
      case 6:
        return certifications();
      case 7:
        return achievements();
      default:
        return buildCompleted();
    }
  }

  final kThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.achOrange,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ColorConstants.achOrange,
                        ),
                      )
                    : SingleChildScrollView(
                        child:
                            // isCompleted
                            //     ? buildCompleted()
                            //     :
                            Theme(
                          data: kThemeData,
                          child: getBodyWidget(_currentStep),
                        ),
                      );
              }),
            ),
            nextButton(),
          ],
        ),
      ),
    );
  }

  Future apiCall() async {
    switch (_currentStep) {
      case 0: //do nothing

        break;
      case 1: //personal info
        log('updating personal info');

        basicDetails = BasicDetails(
          phone: _phoneController.text,
          dob: intl.DateFormat("dd-MM-yyyy").parse(_dobController.text),
          gender: _selectedGender.toLowerCase(),
        );

        await ApiService.updateStudentProfileBasic(
            studentBasicDetails: basicDetails);

        await getProfileData();

        break;
      case 2: //education details
        log('updating education details');

        await getProfileData();

        break;
      case 3: //skill set
        log('updating skill set');

        await ApiService.updateStudentProfileSkills(
            studentSkills: industrySkillsMap.keys.toList(),
            skillType: 'skills');

        await ApiService.updateStudentProfileSkills(
            studentSkills: softSkillsMap.keys.toList(),
            skillType: 'softSkills');

        await ApiService.updateStudentProfileSkills(
            studentSkills: languagesMap.keys.toList(), skillType: 'languages');

        await getProfileData();

        break;
      case 4: //internship experience
        log('updating internship experience');

        for (var addInternData in internshipsList) {
          if (addInternData.id == null) {
            await ApiService.updateStudentProfileInternships(
                studentInternshipDetails: addInternData);
          }
        }

        await getProfileData();
        break;
      case 5: //projects

        log('updating projects');

        for (var addProjectData in projectsList) {
          if (addProjectData.id == null) {
            await ApiService.updateStudentProfileProjects(
                studentProjectDetails: addProjectData);
          }
        }
        await getProfileData();
        break;
      case 6: //certifications

        log('updating certifications');

        for (var addCertificationData in certificationsList) {
          if (addCertificationData.id == null) {
            await ApiService.updateStudentProfileCertifications(
                studentCertificationDetails: addCertificationData);
          }
        }
        await getProfileData();
        break;
      case 7: //achievements

        log('updating achievements');

        for (var addAchievementData in achievementsList) {
          if (addAchievementData.id == null) {
            await ApiService.updateStudentProfileAchievements(
                studentAchievementDetails: addAchievementData);
          }
        }
        await getProfileData();
        break;

      default: //nothing
        await getProfileData();
        break;
    }
  }

  Widget nextButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          if (_formKeys[_currentStep - 1].currentState!.validate() ||
              _currentStep >= 4) {
            //complete profile
            if (_currentStep == 7) {
              await apiCall();
              // setState(() => isCompleted = true);
              //navigate to dashboard
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ),
              );
            }
            //education details
            else if (_currentStep == 2) {
              if (educationDetails.tenth != null &&
                  educationDetails.twelfth != null &&
                  educationDetails.ug != null) {
                await apiCall();
                setState(() => _currentStep++);
              } else {
                _showSnackBar(
                    'Please add all the education details to proceed.');
              }
            }
            //other steps
            else {
              await apiCall();
              setState(() => _currentStep++);
            }
          }
          setState(() {
            isLoading = false;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.nextButton,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                _currentStep == 7 ? 'Complete Profile' : 'Next',
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                if (_currentStep == 1) {
                  Navigator.pop(context);
                } else {
                  await getProfileData();
                  setState(() => _currentStep--);
                }
              },
              child: const Icon(
                Icons.chevron_left_outlined,
                size: 32,
              ),
            ),
            title: Text(headings[_currentStep]),
            subtitle: Text(_currentStep == 7
                ? 'Finish your profile'
                : 'Next: ${headings[_currentStep + 1]}'),
            trailing: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: _currentStep / 7,
                    backgroundColor: const Color.fromRGBO(92, 116, 200, 0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFF49424)),
                  ),
                ),
                Text(
                  "$_currentStep of 7",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1.3,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );
  }

// function for form reset
  void clearEducationForm() {
    setState(() {
      _formKeys[1].currentState!.reset();
      _selectedClass = 'Select Class';
      _selectedGradeScale = 'Select Scale';
      _institutionController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _gradeController.clear();
    });
  }

  void fillEducationForm(Degree degree) {
    setState(() {
      _selectedGradeScale = degree.gradeScale == 10 ? 'CGPA' : 'Percentage';
      _institutionController.text = degree.institution.toString();
      _startDateController.text = degree.startYear.toString();
      _endDateController.text = degree.endYear.toString();
      _gradeController.text = degree.grade.toString();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

// widget for each step
  Widget personalInfo() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[0],
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/icons/loginLogo.png'),
                image: NetworkImage(_photoUrl ?? ''),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      height: SizeConfig.blockSizeVertical * 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[500],
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.white,
                      ));
                },
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),
            Text(
              'Upload Profile Picture',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3.5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _fnameController,
                    enabled: false,
                    // style: theme.textTheme.bodyLarge!.copyWith(
                    //   color: theme.disabledColor,
                    // ),
                    decoration: InputDecoration(
                      // labelText: 'First Name',
                      label: mandateLabel('First Name'),
                    ),
                  ),
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                Expanded(
                  child: TextFormField(
                    controller: _lnameController,
                    enabled: false,
                    // style: theme.textTheme.bodyLarge!.copyWith(
                    //   color: theme.disabledColor,
                    // ),
                    decoration: InputDecoration(
                      label: mandateLabel('Last Name'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            TextFormField(
              controller: _acharyaEmailController,
              enabled: false,
              // style: theme.textTheme.bodyLarge!.copyWith(
              //   color: theme.disabledColor,
              // ),
              decoration: InputDecoration(
                label: mandateLabel('Acharya Email ID'),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            TextFormField(
              controller: _usnController,
              enabled: false,
              decoration: InputDecoration(
                label: mandateLabel('USN'),
              ),
            ),
            // SizedBox(height: SizeConfig.blockSizeVertical * 2),
            // TextFormField(
            //   controller: _personalEmailController,
            //   decoration: InputDecoration(
            //     label: mandateLabel('Personal Email ID'),
            //   ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Please enter your personal email id';
            //     }
            //     return null;
            //   },
            // ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                label: mandateLabel('Phone Number'),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if (value!.length != 10) {
                  return 'Please enter a valid phone number';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            TextFormField(
              controller: _dobController,
              readOnly: true,
              decoration: InputDecoration(
                // labelText: 'Date of Birth',
                label: mandateLabel('Date of Birth'),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select your date of birth';
                } else {
                  return null;
                }
              },
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDatePickerMode: DatePickerMode.year,
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 365 * 20)),
                  firstDate: DateTime.now().add(const Duration(days: -12000)),
                  lastDate: DateTime.now().add(const Duration(days: 1000)),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary:
                              ColorConstants.achBlue, // header background color
                          // onPrimary: Colors.black, // header text color
                          onSurface: Colors.black, // body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                ColorConstants.nextButton, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    _dobController.text =
                        intl.DateFormat('dd-MM-yyyy').format(picked);
                    // picked.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            DropdownButtonFormField(
              value: _selectedGender,
              decoration: InputDecoration(
                label: mandateLabel('Gender'),
              ),
              validator: (value) {
                if (value == 'Select Gender' || value == null) {
                  return 'Please select your gender';
                } else {
                  return null;
                }
              },
              items: _genderList
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget educationalDetails() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[1],
        child: Column(
          children: [
            if (educationDetails.tenth != null)
              classDetail(educationDetails.tenth!, '10th'),
            if (educationDetails.twelfth != null)
              classDetail(educationDetails.twelfth!, '12th'),
            if (educationDetails.ug != null)
              classDetail(educationDetails.ug!, 'UG'),
            if (educationDetails.ug != null ||
                educationDetails.tenth != null ||
                educationDetails.twelfth != null)
              Visibility(
                visible: !(educationDetails.ug != null &&
                    educationDetails.tenth != null &&
                    educationDetails.twelfth != null),
                child: Column(
                  children: [
                    const Divider(thickness: 1.3),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  ],
                ),
              ),
            Visibility(
              visible: !(educationDetails.ug != null &&
                  educationDetails.tenth != null &&
                  educationDetails.twelfth != null),
              child: Column(
                children: [
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    value: _selectedClass,
                    decoration: const InputDecoration(
                      labelText: 'Select Class',
                    ),
                    validator: (value) {
                      if (value == 'Select Class' || value == null) {
                        return 'Please select your class';
                      } else {
                        return null;
                      }
                    },
                    items: _classList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedClass = value!;
                        if (_selectedClass == '10th') {
                          if (educationDetails.tenth != null) {
                            fillEducationForm(educationDetails.tenth!);
                          } else {
                            clearEducationForm();
                            _selectedClass = '10th';
                          }
                        } else if (_selectedClass == '12th') {
                          if (educationDetails.twelfth != null) {
                            fillEducationForm(educationDetails.twelfth!);
                          } else {
                            clearEducationForm();
                            _selectedClass = '12th';
                          }
                        } else if (_selectedClass == 'UG') {
                          if (educationDetails.ug != null) {
                            fillEducationForm(educationDetails.ug!);
                          } else {
                            clearEducationForm();
                            _selectedClass = 'UG';
                          }
                        }
                      });
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  TextFormField(
                    controller: _institutionController,
                    decoration: const InputDecoration(
                      labelText: 'Institution Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your institution name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startDateController,
                            decoration: const InputDecoration(
                              labelText: 'Start Year',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter start year';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                        Expanded(
                          child: TextFormField(
                            controller: _endDateController,
                            decoration: const InputDecoration(
                              labelText: 'End Year',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter end year';
                              } else if (int.tryParse(
                                      _startDateController.text)! >
                                  int.tryParse(_endDateController.text)!) {
                                return 'Invalid end year';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _gradeController,
                            decoration: const InputDecoration(
                              labelText: 'Grade/Percentage',
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d{0,2}(\.\d{0,2})?')),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter grade';
                              } else {
                                if (_selectedGradeScale == 'Percentage' &&
                                    (double.tryParse(value)! <= 0 ||
                                        double.tryParse(value)! > 100)) {
                                  return 'Invalid Percentage';
                                } else if (_selectedGradeScale == 'CGPA' &&
                                    (double.tryParse(value)! <= 0 ||
                                        double.tryParse(value)! > 10)) {
                                  return 'Invalid CGPA';
                                }
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                        Flexible(
                          child: DropdownButtonFormField(
                            value: _selectedGradeScale,
                            decoration: const InputDecoration(
                              labelText: 'Select Scale',
                            ),
                            validator: (value) {
                              if (value == 'Select Scale' || value == null) {
                                return 'Please select scale';
                              } else {
                                return null;
                              }
                            },
                            items: _gradeScaleList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGradeScale = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        if (_formKeys[1].currentState!.validate()) {
                          if (_selectedClass == '10th') {
                            educationDetails.tenth = Degree(
                              institution: _institutionController.text,
                              startYear:
                                  int.parse(_startDateController.text).toInt(),
                              endYear:
                                  int.parse(_endDateController.text).toInt(),
                              grade: double.parse(_gradeController.text)
                                  .toDouble(),
                              gradeScale:
                                  _selectedGradeScale == 'CGPA' ? 10 : 100,
                            );

                            await ApiService.updateStudentProfileEducation(
                              studentEducationDetails: educationDetails.tenth!,
                              education: _selectedClass,
                            );

                            clearEducationForm();
                            _showSnackBar('10th Details Added');
                          } else if (_selectedClass == '12th') {
                            educationDetails.twelfth = Degree(
                              institution: _institutionController.text,
                              startYear: int.parse(_startDateController.text),
                              endYear: int.parse(_endDateController.text),
                              grade: double.parse(_gradeController.text),
                              gradeScale:
                                  _selectedGradeScale == 'CGPA' ? 10 : 100,
                            );

                            await ApiService.updateStudentProfileEducation(
                              studentEducationDetails:
                                  educationDetails.twelfth!,
                              education: _selectedClass,
                            );
                            clearEducationForm();
                            _showSnackBar('12th Details Added');
                          } else if (_selectedClass == 'UG') {
                            educationDetails.ug = Degree(
                              institution: _institutionController.text,
                              startYear: int.parse(_startDateController.text),
                              endYear: int.parse(_endDateController.text),
                              grade: double.parse(_gradeController.text),
                              gradeScale:
                                  _selectedGradeScale == 'CGPA' ? 10 : 100,
                            );

                            await ApiService.updateStudentProfileEducation(
                              studentEducationDetails: educationDetails.ug!,
                              education: _selectedClass,
                            );
                            clearEducationForm();
                            _showSnackBar('UG Details Added');
                          }
                        }
                      },
                      child: Text(
                        _selectedClass == '10th'
                            ? educationDetails.tenth != null
                                ? 'Update'
                                : '+ Add Another Class'
                            : _selectedClass == '12th'
                                ? educationDetails.twelfth != null
                                    ? 'Update'
                                    : '+ Add Another Class'
                                : _selectedClass == 'UG'
                                    ? educationDetails.ug != null
                                        ? 'Update'
                                        : '+ Add Another Class'
                                    : '+ Add Another Class',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget skillSet() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[2],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dropdownSearch('Industry Skills', industrySkillsMap, 'skills'),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            dropdownSearch('Soft Skills', softSkillsMap, 'softSkills'),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            dropdownSearch('Languages', languagesMap, 'languages'),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
          ],
        ),
      ),
    );
  }

  Widget internshipExperience() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[3],
        child: Column(
          children: [
            if (internshipsList.isNotEmpty)
              Column(
                children: [
                  for (var i = 0; i < internshipsList.length; i++)
                    internDetail(internshipsList[i]),
                  const Divider(thickness: 1.3),
                  const SizedBox(height: 20),
                ],
              ),
            TextFormField(
              controller: _roleController,
              decoration: const InputDecoration(
                labelText: 'Designation',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your designation';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter company name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _internStartDateController,
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDatePickerMode: DatePickerMode.day,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              String month =
                                  intl.DateFormat('MMM').format(value);
                              String year = value.year.toString();
                              _internStartDateController.text = '$month $year';
                            });
                          }
                        });
                      },
                    ),
                  ),
                  if (!_ongoing) const SizedBox(width: 20),
                  if (!_ongoing)
                    Expanded(
                      child: TextFormField(
                        enabled: !_ongoing,
                        controller: _internEndDateController,
                        decoration: const InputDecoration(
                          labelText: 'End Date',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter end date';
                          }
                          return null;
                        },
                        onTap: () async {
                          showDatePicker(
                            context: context,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                String month =
                                    intl.DateFormat('MMM').format(value);
                                String year = value.year.toString();
                                _internEndDateController.text = '$month $year';
                              });
                            }
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  checkColor: ColorConstants.achOrange,
                  activeColor: Colors.black,
                  fillColor: WidgetStateProperty.all(Colors.white),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                        width: 1.0, color: ColorConstants.achOrange),
                  ),
                  visualDensity: VisualDensity.compact,
                  value: _ongoing,
                  onChanged: (value) {
                    setState(() {
                      _internEndDateController.clear();
                      _ongoing = value!;
                    });
                  },
                ),
                const Text('Present (Currently working here)'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              minLines: 3,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                  labelText: 'Description', alignLabelWithHint: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () async {
                  if (_formKeys[3].currentState!.validate()) {
                    InternshipDetail addInternData = InternshipDetail(
                      companyName: _companyNameController.text,
                      startMonth: _internStartDateController.text.split(' ')[0],
                      startYear: int.tryParse(
                          _internStartDateController.text.split(' ')[1]),
                      endMonth: _internEndDateController.text.split(' ')[0],
                      endYear: int.tryParse(
                          _internEndDateController.text.split(' ')[1]),
                      role: _roleController.text,
                      description: _descriptionController.text,
                      ongoing: _ongoing,
                    );
                    // await ApiService.updateStudentProfileInternships(
                    //     studentInternshipDetails: addInternData);
                    setState(() {
                      internshipsList.add(addInternData);
                      _companyNameController.clear();
                      _internStartDateController.clear();
                      _internEndDateController.clear();
                      _roleController.clear();
                      _descriptionController.clear();
                      _ongoing = false;
                    });
                  }
                },
                child: const Text(
                  '+ Add Another Role',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget projects() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[4],
        child: Column(
          children: [
            if (projectsList.isNotEmpty)
              Column(
                children: [
                  for (var i = 0; i < projectsList.length; i++)
                    projectDetail(projectsList[i]),
                  const Divider(thickness: 1.3),
                  const SizedBox(height: 20),
                ],
              ),
            TextFormField(
              controller: _projectTitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your project title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _projectLinkController,
              decoration: const InputDecoration(
                labelText: 'Project Link',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter project link';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _projectDescriptionController,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter project description';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  if (_formKeys[4].currentState!.validate() &&
                      _projectTitleController.text.isNotEmpty &&
                      _projectLinkController.text.isNotEmpty &&
                      _projectDescriptionController.text.isNotEmpty) {
                    setState(() {
                      projectsList.add(Achievement(
                        title: _projectTitleController.text,
                        link: _projectLinkController.text,
                        description: _projectDescriptionController.text,
                      ));
                    });
                  }
                },
                child: const Text(
                  '+ Add Another Project',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget certifications() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[5],
        child: Column(
          children: [
            if (certificationsList.isNotEmpty)
              Column(
                children: [
                  for (var i = 0; i < certificationsList.length; i++)
                    certificationDetail(certificationsList[i]),
                  const Divider(thickness: 1.3),
                  const SizedBox(height: 20),
                ],
              ),
            TextFormField(
              controller: _certificateTitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your certificate title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _certificateOrganizationController,
              decoration: const InputDecoration(
                labelText: 'Issuing Organization',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter issuing organization';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _certificateDescriptionController,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter certificate description';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _certificateLinkController,
              decoration: const InputDecoration(
                labelText: 'Link',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter certificate link';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  if (_formKeys[5].currentState!.validate()) {
                    setState(() {
                      certificationsList.add(Certification(
                        title: _certificateTitleController.text,
                        link: _certificateLinkController.text,
                        description: _certificateDescriptionController.text,
                        organization: _certificateOrganizationController.text,
                      ));
                    });
                  }
                },
                child: const Text(
                  '+ Add Another Certificate',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget achievements() {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
      child: Form(
        key: _formKeys[6],
        child: Column(
          children: [
            if (achievementsList.isNotEmpty)
              Column(
                children: [
                  for (var i = 0; i < achievementsList.length; i++)
                    achievementDetail(achievementsList[i]),
                  const Divider(thickness: 1.3),
                  const SizedBox(height: 20),
                ],
              ),
            TextFormField(
              controller: _achievementTitleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your achievement title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _achievementOrganizationController,
              decoration: const InputDecoration(
                labelText: 'Issuing Organization',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter issuing organization';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _achievementDescriptionController,
              maxLines: 5,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter achievement description';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _achievementLinkController,
              decoration: const InputDecoration(
                labelText: 'Link',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter achievement link';
                } else {
                  return null;
                }
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  if (_formKeys[6].currentState!.validate()) {
                    setState(() {
                      achievementsList.add(Achievement(
                        title: _achievementTitleController.text,
                        link: _achievementLinkController.text,
                        organization: _achievementOrganizationController.text,
                        description: _achievementDescriptionController.text,
                      ));
                    });
                  }
                },
                child: const Text(
                  '+ Add Another Achievement',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCompleted() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have successfully completed the form',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentStep = 1;
                // isCompleted = false;
              });
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  //common widget for all the steps
  Widget dropdownSearch(String name, Map<String, Skill> map, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: ColorConstants.achBlue,
            fontSize: SizeConfig.blockSizeHorizontal * 4.7,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        DropdownFormField<Skill>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          emptyText: 'Enter to add skill',
          emptyActionText: 'Add Skill',
          displayItemFn: (dynamic item) {
            return Text(
              item.toString() == 'null' ? 'Select Skill' : item.toString(),
              style: const TextStyle(fontSize: 16),
            );
          },
          findFn: (dynamic str) async => await getSkills(str, type),
          dropdownItemFn: (dynamic item, int position, bool focused,
              bool selected, Function() onTap) {
            return ListTile(
              leading: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setSS) {
                return Checkbox(
                  value: map.containsKey(item.id),
                  onChanged: (bool? value) {
                    if (value == true) {
                      setSS(() => map[item.id] = item);
                    } else {
                      setSS(() => map.remove(item.id));
                    }
                    setState(() {});
                  },
                );
              }),
              title: Text(item.toString()),
              tileColor: focused
                  ? const Color.fromARGB(20, 0, 0, 0)
                  : Colors.transparent,
            );
          },
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        if (map.isNotEmpty)
          Wrap(
            children: map.values
                .map(
                  (Skill skill) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: ColorConstants.achBlue,
                        width: 1,
                      ),
                      label: Text(
                        skill.name!,
                        style: const TextStyle(color: ColorConstants.achBlue),
                      ),
                      backgroundColor: Colors.white,
                      deleteIcon: const Icon(
                        Icons.close,
                        color: ColorConstants.achBlue,
                      ),
                      onDeleted: () {
                        setState(() => map.remove(skill.id));
                      },
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget classDetail(Degree degree, String className) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical * 2,
          right: SizeConfig.blockSizeHorizontal * 2,
          left: SizeConfig.blockSizeHorizontal * 2),
      decoration: BoxDecoration(
        color: const Color(0xffEAF2FF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.school_rounded,
          ),
        ),
        trailing: PopupMenuButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              onTap: () {
                setState(() {
                  fillEducationForm(degree);
                  if (className == '10th') {
                    educationDetails.tenth = null;
                  } else if (className == '12th') {
                    educationDetails.twelfth = null;
                  } else if (className == 'UG') {
                    educationDetails.ug = null;
                  }
                  _selectedClass = className;
                });
              },
              child: Row(
                children: const [
                  Text('Edit'),
                  Spacer(),
                  Icon(Icons.edit),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              onTap: () {
                setState(() {
                  clearEducationForm();
                  if (className == '10th') {
                    educationDetails.tenth = null;
                  } else if (className == '12th') {
                    educationDetails.twelfth = null;
                  } else if (className == 'UG') {
                    educationDetails.ug = null;
                  }
                  _selectedClass = className;
                });
              },
              child: Row(
                children: const [
                  Text('Delete'),
                  Spacer(),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ],
        ),
        title: Text(
          degree.institution!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              className,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${degree.startYear} - ${degree.endYear}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${degree.grade} ${degree.gradeScale == 10 ? 'CGPA' : '%'}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget internDetail(InternshipDetail internshipDetail) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 15, right: 5, left: 5, top: 5),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffEAF2FF),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(1, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Designation: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Flexible(
                    child: Text(
                      internshipDetail.role.toString(),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Company Name: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Flexible(
                    child: Text(
                      internshipDetail.companyName.toString(),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Start Date: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(
                    '${internshipDetail.startMonth!.capitalize()} ${internshipDetail.startYear}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'End Year: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Text(
                    internshipDetail.endYear.toString() == 'null'
                        ? 'Ongoing'
                        : '${internshipDetail.endMonth!.capitalize()} ${internshipDetail.endYear}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description: ',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  Flexible(
                    child: Text(
                      internshipDetail.description.toString(),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //popup menu
        Positioned(
          top: 20,
          right: 15,
          child: PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            onSelected: (value) async {
              if (value == 1) {
                setState(() {
                  _roleController.text = internshipDetail.role.toString();
                  _companyNameController.text =
                      internshipDetail.companyName.toString();
                  _internStartDateController.text =
                      '${internshipDetail.startMonth!.capitalize()} ${internshipDetail.startYear}';
                  if (internshipDetail.ongoing == false) {
                    _internEndDateController.text =
                        '${internshipDetail.endMonth!.capitalize()} ${internshipDetail.endYear}';
                  }
                  _descriptionController.text =
                      internshipDetail.description.toString();

                  internshipsList.remove(internshipDetail);
                });
              } else if (value == 2) {
                await ApiService.deleteStudentProfileInternshipsById(
                  internshipId: internshipDetail.id!,
                );
                setState(() {
                  internshipsList.remove(internshipDetail);
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Text('Edit'),
                    Spacer(),
                    Icon(Icons.edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Text('Delete'),
                    Spacer(),
                    Icon(Icons.delete),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: 5,
        //   right: -5,
        //   child: IconButton(
        //     onPressed: () {
        //       setState(() {
        //         _roleController.text = internshipDetail.role.toString();
        //         _companyNameController.text =
        //             internshipDetail.companyName.toString();
        //         _internStartDateController.text =
        //             '${internshipDetail.startMonth!.capitalize()} ${internshipDetail.startYear}';
        //         if (internshipDetail.ongoing == false) {
        //           _internEndDateController.text =
        //               '${internshipDetail.endMonth!.capitalize()} ${internshipDetail.endYear}';
        //         }
        //         _descriptionController.text =
        //             internshipDetail.description.toString();
        //       });
        //     },
        //     icon: const Icon(Icons.edit),
        //   ),
        // ),
        // Positioned(
        //   top: 5,
        //   right: 35,
        //   child: IconButton(
        //     onPressed: () async {
        //       await ApiService.deleteStudentProfileInternshipsById(
        //         internshipId: internshipDetail.id!,
        //       );
        //       setState(() {
        //         internshipsList.remove(internshipDetail);
        //       });
        //     },
        //     icon: const Icon(Icons.delete),
        //   ),
        // ),
      ],
    );
  }

  Widget projectDetail(Achievement projectDetail) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffEAF2FF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projectDetail.title.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            projectDetail.description.toString(),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'View Project',
                  style: TextStyle(
                    color: ColorConstants.achBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  textDirection: TextDirection.ltr,
                  color: ColorConstants.achBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget certificationDetail(Certification certificationDetail) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffEAF2FF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            certificationDetail.title.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            certificationDetail.organization.toString(),
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            certificationDetail.description.toString(),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'View Certificate',
                  style: TextStyle(
                    color: ColorConstants.achBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  textDirection: TextDirection.ltr,
                  color: ColorConstants.achBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget achievementDetail(Achievement achievementDetail) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffEAF2FF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            achievementDetail.title.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            achievementDetail.organization.toString(),
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            achievementDetail.description.toString(),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'View Organization',
                  style: TextStyle(
                    color: ColorConstants.achBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  textDirection: TextDirection.ltr,
                  color: ColorConstants.achBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
