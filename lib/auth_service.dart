import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }
}
