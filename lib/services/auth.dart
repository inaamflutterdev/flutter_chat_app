import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user!;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future signUpwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user!;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
      // ignore: empty_catches
    } catch (e) {}
  }
}
