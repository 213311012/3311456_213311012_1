import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/servis/auth_base.dart';
import 'package:gezi_uygulamam/servis/bulucu.dart';
import 'package:gezi_uygulamam/servis/firestore_DB_servis.dart';

import '../servis/fake_auth_servis.dart';
import '../servis/firebase_auth_servis.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  // kullanıcı ile ilgili işlemler ve her türlü kullanıcı mantıgı burada olacak

  FirebaseAuthServis _firebaseAuthServis = locator<FirebaseAuthServis>();
  FakeAuthServis _fakeAuthServis = locator<FakeAuthServis>();
  FirestoreDBServis _firestoreDBServis = locator<FirestoreDBServis>();

  AppMode appMode = AppMode.RELEASE;

  @override
  Future<MyUser?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServis.currentUser();
    } else {
      MyUser? _user = await _firebaseAuthServis.currentUser();
      return await _firestoreDBServis.readUser(_user!.userID);
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServis.signOut();
    } else {
      return await _firebaseAuthServis.signOut();
    }
  }

  @override
  Future<MyUser?> singInAnonymously() async {
    if (appMode == AppMode.RELEASE) {
      return await _fakeAuthServis.singInAnonymously();
    } else {
      return await _firebaseAuthServis.singInAnonymously();
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServis.signInWithGoogle();
    } else {
      MyUser _user = await _firebaseAuthServis.signInWithGoogle();

      bool _sonuc = await _firestoreDBServis.saveUser(_user);
      if (_sonuc) {
        return _user;
      } else
        return null;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServis.createUserWithEmailandPassword(email, sifre);
    } else {
      MyUser? _user = await _firebaseAuthServis.createUserWithEmailandPassword(
          email, sifre);
      bool _sonuc = await _firestoreDBServis.saveUser(_user!);
      if (_sonuc) {
        return await _firestoreDBServis.readUser(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(String email, String sifre) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthServis.signInWithEmailandPassword(email, sifre);
    } else {
      MyUser? _user =
          await _firebaseAuthServis.signInWithEmailandPassword(email, sifre);
      return await _firestoreDBServis.readUser(_user!.userID);
    }
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBServis.updateUserName(userID, yeniUserName);
    }
  }
}
