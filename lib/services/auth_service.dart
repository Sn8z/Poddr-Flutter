import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final fireProvider = Provider<FirebaseAuth>(
  (ref) {
    return FirebaseAuth.instance;
  },
);

final authProvider = ChangeNotifierProvider(
  (ref) {
    return AuthService(ref.watch(fireProvider));
  },
);

final userProvider = StreamProvider<User?>(
  (ref) => ref.watch(fireProvider).authStateChanges(),
);

class AuthService with ChangeNotifier {
  final FirebaseAuth fbAuth;
  User? fbUser;

  AuthService(this.fbAuth) {
    debugPrint('AuthService constructor');
  }

  User? get user => fbAuth.currentUser;

  bool isLoggedIn() {
    return fbAuth.currentUser != null;
  }

  // Create new user
  Future<void> createNewUser(String email, String password) async {
    await fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    debugPrint("Auth sign in -");
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
      switch (e.code) {
        case "invalid-email":
          {
            debugPrint('invalid email');
          }
      }
    }
  }

  // Sign in anonymously
  Future<void> signInAnonymously() async {
    debugPrint("Auth Anon sign in -");
    try {
      await fbAuth.signInAnonymously();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    debugPrint("Auth sign out -");
    try {
      await fbAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
