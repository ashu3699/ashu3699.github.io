class AuthService {
  String? login({required String email, required String password}) {
    if (email == 'admin' && password == 'admin') {
      return 'Demo Login Successful!';
    }
    return null;
  }
}
