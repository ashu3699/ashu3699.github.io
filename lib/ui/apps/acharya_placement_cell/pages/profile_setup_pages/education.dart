// // part of 'profile_setup_page.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../constants.dart';
// import '../../models/main_model.dart';

// class EducationSection extends StatefulWidget {
//   const EducationSection({super.key, required this.formKey});
//   final GlobalKey<FormState> formKey;

//   @override
//   State<EducationSection> createState() => _EducationSectionState();
// }

// class _EducationSectionState extends State<EducationSection> {
//   EducationDetails educationDetails = EducationDetails();
//   final _institutionController = TextEditingController(),
//       _startDateController = TextEditingController(),
//       _endDateController = TextEditingController(),
//       _gradeController = TextEditingController();
//   final _classList = ['Select Class', '10th', '12th', 'UG'];
//   String _selectedClass = 'Select Class';
//   final _gradeScaleList = ['Select Scale', 'CGPA', 'Percentage'];
//   String _selectedGradeScale = 'Select Scale';

//   @override
//   Widget build(BuildContext context) {
//     final formKey = widget.formKey;

//     return Container(
//       margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
//       child: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             if (educationDetails.tenth != null)
//               classDetail(educationDetails.tenth!, '10th'),
//             if (educationDetails.twelfth != null)
//               classDetail(educationDetails.twelfth!, '12th'),
//             if (educationDetails.ug != null)
//               classDetail(educationDetails.ug!, 'UG'),
//             if (educationDetails.ug != null ||
//                 educationDetails.tenth != null ||
//                 educationDetails.twelfth != null)
//               Column(
//                 children: [
//                   const Divider(thickness: 1.3),
//                   SizedBox(height: SizeConfig.blockSizeVertical * 2),
//                 ],
//               ),
//             // Column(
//             //   children: [
//             // if (educationDetails.tenth != null)
//             //   classDetail(educationDetails.tenth!, '10th'),
//             // if (educationDetails.twelfth != null)
//             //   classDetail(educationDetails.twelfth!, '12th'),
//             // if (educationDetails.ug != null)
//             //   classDetail(educationDetails.ug!, 'UG'),
//             // if (educationDetails.ug != null ||
//             //     educationDetails.tenth != null ||
//             //     educationDetails.twelfth != null)
//             //   Column(
//             //     children: [
//             //       const Divider(thickness: 1.3),
//             //       SizedBox(height: SizeConfig.blockSizeVertical * 2),
//             //     ],
//             //   ),
//             //   ],
//             // ),
//             DropdownButtonFormField(
//               borderRadius: BorderRadius.circular(10),
//               value: _selectedClass,
//               decoration: const InputDecoration(
//                 labelText: 'Select Class',
//               ),
//               validator: (value) {
//                 if (value == 'Select Class' || value == null) {
//                   return 'Please select your class';
//                 } else {
//                   return null;
//                 }
//               },
//               items: _classList
//                   .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedClass = value!;
//                 });
//               },
//             ),
//             SizedBox(height: SizeConfig.blockSizeVertical * 2),
//             TextFormField(
//               controller: _institutionController,
//               decoration: const InputDecoration(
//                 labelText: 'Institution Name',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your institution name';
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//             SizedBox(height: SizeConfig.blockSizeVertical * 2),
//             IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _startDateController,
//                       decoration: const InputDecoration(
//                         labelText: 'Start Year',
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(4),
//                       ],
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter start year';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _endDateController,
//                       decoration: const InputDecoration(
//                         labelText: 'End Year',
//                         suffixIcon: Icon(Icons.calendar_today),
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(4),
//                       ],
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter end year';
//                         }
//                         //check if end date is greater than start date
//                         else if (int.tryParse(_startDateController.text)! >
//                             int.tryParse(_endDateController.text)!) {
//                           return 'Invalid end year';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: SizeConfig.blockSizeVertical * 2),
//             IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Flexible(
//                     child: TextFormField(
//                       controller: _gradeController,
//                       decoration: const InputDecoration(
//                         labelText: 'Grade/Percentage',
//                       ),
//                       keyboardType: TextInputType.phone,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(
//                             RegExp(r'^\d{0,2}(\.\d{0,2})?')),
//                       ],
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter grade';
//                         } else {
//                           if (_selectedGradeScale == 'Percentage' &&
//                               (double.tryParse(value)! <= 0 ||
//                                   double.tryParse(value)! > 100)) {
//                             return 'Invalid Percentage';
//                           } else if (_selectedGradeScale == 'CGPA' &&
//                               (double.tryParse(value)! <= 0 ||
//                                   double.tryParse(value)! > 10)) {
//                             return 'Invalid CGPA';
//                           }
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
//                   Flexible(
//                     child: DropdownButtonFormField(
//                       value: _selectedGradeScale,
//                       decoration: const InputDecoration(
//                         labelText: 'Select Scale',
//                       ),
//                       validator: (value) {
//                         if (value == 'Select Scale' || value == null) {
//                           return 'Please select scale';
//                         } else {
//                           return null;
//                         }
//                       },
//                       items: _gradeScaleList
//                           .map((e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Text(e),
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedGradeScale = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: SizeConfig.blockSizeVertical * 2),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TextButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate() &&
//                       _institutionController.text.isNotEmpty &&
//                       _startDateController.text.isNotEmpty &&
//                       _endDateController.text.isNotEmpty &&
//                       _gradeController.text.isNotEmpty &&
//                       _selectedGradeScale != 'Select Scale' &&
//                       _selectedClass != 'Select Class') {
//                     setState(() {
//                       if (_selectedClass == '10th') {
//                         educationDetails.tenth = Degree(
//                           institution: _institutionController.text,
//                           startYear: int.parse(_startDateController.text),
//                           endYear: int.parse(_endDateController.text),
//                           grade: double.parse(_gradeController.text),
//                           gradeScale: _selectedGradeScale == 'CGPA' ? 10 : 100,
//                         );
//                         //clear the form
//                         formKey.currentState!.reset();
//                       } else if (_selectedClass == '12th') {
//                         educationDetails.twelfth = Degree(
//                           institution: _institutionController.text,
//                           startYear: int.parse(_startDateController.text),
//                           endYear: int.parse(_endDateController.text),
//                           grade: double.parse(_gradeController.text),
//                           gradeScale: _selectedGradeScale == 'CGPA' ? 10 : 100,
//                         );
//                         formKey.currentState!.reset();
//                       } else if (_selectedClass == 'UG') {
//                         educationDetails.ug = Degree(
//                           institution: _institutionController.text,
//                           startYear: int.parse(_startDateController.text),
//                           endYear: int.parse(_endDateController.text),
//                           grade: double.parse(_gradeController.text),
//                           gradeScale: _selectedGradeScale == 'CGPA' ? 10 : 100,
//                         );
//                         formKey.currentState!.reset();
//                       }
//                     });
//                   }
//                 },
//                 child: Text(
//                   _selectedClass == '10th'
//                       ? educationDetails.tenth != null
//                           ? 'Update'
//                           : '+ Add Another Class'
//                       : _selectedClass == '12th'
//                           ? educationDetails.twelfth != null
//                               ? 'Update'
//                               : '+ Add Another Class'
//                           : _selectedClass == 'UG'
//                               ? educationDetails.ug != null
//                                   ? 'Update'
//                                   : '+ Add Another Class'
//                               : '+ Add Another Class',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget classDetail(Degree degree, String className) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(
//           bottom: SizeConfig.blockSizeVertical * 2,
//           right: SizeConfig.blockSizeHorizontal * 2,
//           left: SizeConfig.blockSizeHorizontal * 2),
//       decoration: BoxDecoration(
//         color: const Color(0xffEAF2FF),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(1, 3),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ListTile(
//         dense: true,
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.school_rounded,
//           ),
//         ),
//         trailing: PopupMenuButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.more_vert,
//           ),
//           onSelected: (value) {
//             if (value == 2) {
//               setState(() {
//                 if (className == '10th') {
//                   educationDetails.tenth = null;
//                 } else if (className == '12th') {
//                   educationDetails.twelfth = null;
//                 } else {
//                   educationDetails.ug = null;
//                 }
//               });
//             } else if (value == 1) {
//               setState(() {
//                 _selectedClass = className;
//                 _institutionController.text = degree.institution.toString();
//                 _startDateController.text = degree.startYear.toString();
//                 _endDateController.text = degree.endYear.toString();
//                 _gradeController.text = degree.grade.toString();
//                 _selectedGradeScale =
//                     degree.gradeScale == 10 ? 'CGPA' : 'Percentage';
//               });
//             }
//           },
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 1,
//               child: Row(
//                 children: const [
//                   Text('Edit'),
//                   Spacer(),
//                   Icon(Icons.edit),
//                 ],
//               ),
//             ),
//             PopupMenuItem(
//               value: 2,
//               child: Row(
//                 children: const [
//                   Text('Delete'),
//                   Spacer(),
//                   Icon(Icons.delete),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         title: Text(
//           degree.institution!,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         subtitle: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               className,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               '${degree.startYear} - ${degree.endYear}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               '${degree.grade} ${degree.gradeScale == 10 ? 'CGPA' : '%'}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
