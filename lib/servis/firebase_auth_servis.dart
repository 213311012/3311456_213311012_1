
// ignore_for_file: prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/servis/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServis implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<MyUser?> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      debugPrint('hata current' + e.toString());
      return null;
    }
  }

  MyUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return MyUser(userID: user.uid, email: user.email!);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint('hata singout' + e.toString());
      return false;
    }
  }

  @override
  Future<MyUser?> singInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();

      return _userFromFirebase(sonuc.user!);
    } catch (e) {
      debugPrint('hata anonim' + e.toString());
      return null;
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        User _user = sonuc.user!;
        return _userFromFirebase(_user)!;
      } else {
        // ignore: null_check_always_fails
        return null!;
      }
    } else {
      // ignore: null_check_always_fails
      return null!;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String sifre) async {
  
      UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      return _userFromFirebase(sonuc.user);

    
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(String email, String sifre) async {
    
      UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: sifre);
      return _userFromFirebase(sonuc.user)!;
    
  }
}
