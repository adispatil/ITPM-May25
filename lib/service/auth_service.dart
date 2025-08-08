import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (ex) {
      throw _handleAuthException(ex);
    }
  }

  Future<void> logOutUser() async {
    await _auth.signOut();
  }

  String _handleAuthException(FirebaseAuthException ex) {
    switch (ex.code) {
      case 'email-already-in-use':
        return "An account already exists with this email id";
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password provided is too weak';
      case 'invalid-email':
        return 'Please provide valid email id';
      default:
        return "An error occurred. Please try again.";
    }
  }
}
