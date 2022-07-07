import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;
  User? fbUser;

  AuthService() {
    print("AuthService constructor");
    fbAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        fbUser = fbAuth.currentUser;
      }
      notifyListeners();
    });
  }

  // Returns the curren user
  User getCurrentUser() {
    return fbAuth.currentUser!;
  }

  bool isLoggedIn() {
    return fbAuth.currentUser != null;
  }

  // Create new user
  void createNewUser(String email, String password) async {
    await fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign in with email and password
  void signIn(String email, String password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  // Sign in anonymously
  void signInAnonymously() async {
    await fbAuth.signInAnonymously();
  }

  // Sign out
  void signOut() async {
    await fbAuth.signOut();
  }
}
