import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'api_service.dart';

class AuthService {
  // final _auth = FirebaseAuth.instance;

  static Future<String> getToken() async {
    // final User? user = FirebaseAuth.instance.currentUser;
    // final String? token = await user?.getIdToken();
    // return token ?? 'null';
    return 'null';
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    if (email == 'admin@acharya.ac.in' && password == 'admin') {
      return 'Success';
    } else {
      return 'Invalid Credentials';
    }
    // try {
    //   await _auth.signInWithEmailAndPassword(email: email, password: password);
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

  Future<String?> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      Uri url = Uri.parse('${ApiService.baseUrl}/auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password
        }),
      );

      final Map<String, dynamic> responseJson = json.decode(response.body);
      log(responseJson.toString());
      if (responseJson['success'] == true) {
        // try {
        //   await _auth.signInWithEmailAndPassword(
        //       email: email, password: password);
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
        return 'Account Created Successfully!';
      } else {
        try {
          return responseJson['error']['message'];
        } catch (e) {
          return responseJson['error'];
        }
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Future<String?> resendEmailVerification() async {
  //   try {
  //     Uri url = Uri.parse('${ApiService.baseUrl}/auth/resendEmailVerification');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //       body: jsonEncode({'email': _auth.currentUser!.email.toString()}),
  //     );

  //     final Map<String, dynamic> responseJson = json.decode(response.body);
  //     if (responseJson['success'] == true) {
  //       return 'Verification Email Sent!';
  //     } else {
  //       return responseJson['error'];
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
