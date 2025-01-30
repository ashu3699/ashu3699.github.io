// import 'dart:convert';

// import '../services/api_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:http/http.dart' as http;

class AuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String? login({
    required String email,
    required String password,
  }) {
    if (email == 'admin' && password == 'admin') {
      return 'Demo Login Successful!';
    }
    return null;
    // try {
    //   await _auth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   return 'Success';
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     return 'No user found for that email.';
    //   } else if (e.code == 'wrong-password') {
    //     return 'Wrong password provided for that user.';
    //   } else {
    //     return e.message;
    //   }
    // } catch (e) {
    //   return e.toString();
    // }
  }

  // Future<String?> registerUser({
  //   required String firstName,
  //   required String lastName,
  //   required String phone,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     Uri url = Uri.parse('${ApiService.baseUrl}/auth/register');
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'firstName': firstName,
  //         'lastName': lastName,
  //         'phone': phone,
  //         'email': email,
  //         'password': password
  //       }),
  //     );

  //     final Map<String, dynamic> responseJson = json.decode(response.body);
  //     if (responseJson['success'] == true) {
  //       try {
  //         await _auth.signInWithEmailAndPassword(
  //           email: email,
  //           password: password,
  //         );
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'user-not-found') {
  //           return 'No user found for that email.';
  //         } else if (e.code == 'wrong-password') {
  //           return 'Wrong password provided for that user.';
  //         } else {
  //           return e.message;
  //         }
  //       } catch (e) {
  //         return e.toString();
  //       }
  //       return 'Registration Successful!';
  //     } else {
  //       return responseJson['error'];
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
