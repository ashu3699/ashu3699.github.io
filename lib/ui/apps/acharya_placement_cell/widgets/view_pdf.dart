// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import '../services/api_service.dart';
// import '../services/auth_service.dart';

// class ViewPDF extends StatefulWidget {
//   const ViewPDF({super.key});

//   @override
//   State<ViewPDF> createState() => _ViewPDFState();
// }

// class _ViewPDFState extends State<ViewPDF> {
//   bool loading = false;
//   var headers = {'Content-Type': 'application/pdf'};

//   @override
//   void initState() {
//     super.initState();
//   }

//   getData() async {
//     String token = await AuthService.getToken();
//     headers.addAll({'Authorization': token});
//     if (token == '') {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const url = '${ApiService.baseUrl}/student/profile/pdf';
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: ColorConstants.addBtn,
//         title: const Text('Document'),
//       ),
//       body: pdfBody(url),
//     );
//   }

//   Widget pdfBody(url) {
//     return FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SfPdfViewer.network(url, headers: headers,
//                 onDocumentLoadFailed: (dynamic exception) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Failed to load document')),
//               );
//               Navigator.pop(context);
//             });
//           } else {
//             return const Center(
//               child: Text('Error'),
//             );
//           }
//         });
//   }
// }
