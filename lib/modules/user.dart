import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class User {
  FirebaseUser _user;
  String _uid;

  
  // Will sign in the user to the firebase.
  // Accepts a string for email and password.
  // Will return true or false if sign in was succesfull or not.
  Future<bool> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password).then((u) {
      _user = u;
      _uid = _user.uid;

      return true;
    }).catchError((error) {
      // If username or password is wrong
      if (error.code == 'ERROR_WRONG_PASSWORD' || error.code == 'ERROR_USER_NOT_FOUND') {
        print('Wrong Username or Password');
        return false;
      }
    });
  }

  String get getUser {
    return _user.toString();
  }

  String get uid => _uid;
}
