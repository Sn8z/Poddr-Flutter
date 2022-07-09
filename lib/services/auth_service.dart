import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authProvider = ChangeNotifierProvider(
  (ref) => AuthService(ref),
);

final userProvider = StreamProvider<User?>(
  (ref) => ref.watch(authProvider).userStream,
);

final isLoggedInProvider = StateProvider<bool>(
  (ref) => ref.watch(authProvider).isLoggedIn(),
);

class AuthService with ChangeNotifier {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;
  User? fbUser;
  final Ref ref;

  AuthService(this.ref) {
    print('AuthService constructor');
  }

  User? get user => fbAuth.currentUser;

  Stream<User?> get userStream => fbAuth.authStateChanges();

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
    print("Auth sign in -");
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  // Sign in anonymously
  Future<void> signInAnonymously() async {
    print("Auth Anon sign in -");
    try {
      await fbAuth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    print("Auth sign out -");
    try {
      await fbAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
