import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  late final FirebaseAuth _auth;

  String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:9054'
      : 'localhost:9054';

  AuthService() {
    FirebaseAuth.instance.useEmulator(host);
    _auth = FirebaseAuth.instance;
  }

  User? get getUser => _auth.currentUser;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    return user;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;

    return user;
  }

  Future<User?> signInAnonymously() async {
    UserCredential result = await _auth.signInAnonymously();

    User? user = result.user;

    return user;
  }

  Future<User?> signInWithGoogle() async {
    UserCredential result = await _auth.signInWithCredential(
      GoogleAuthProvider.credential(
        idToken:
            '{"sub": "abc123", "email": "blue@example.com", "email_verified": true}',
      ),
    );

    return result.user;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
