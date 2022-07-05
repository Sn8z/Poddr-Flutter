import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth fbAuth = FirebaseAuth.instance;

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
    notifyListeners();
  }

  // Sign in with email and password
  void signIn(String email, String password) async {
    await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  // Sign in anonymously
  void signInAnonymously() async {
    await fbAuth.signInAnonymously();
    notifyListeners();
  }

  // Sign out
  void signOut() async {
    await fbAuth.signOut();
    notifyListeners();
  }
}
