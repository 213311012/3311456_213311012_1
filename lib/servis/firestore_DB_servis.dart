// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/servis/datebase_base.dart';

class FirestoreDBServis implements DBbase {
  final FirebaseFirestore _firebaseDB = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(MyUser user) async {
    await _firebaseDB.collection('users').doc(user.userID).set(user.toMap());

    DocumentSnapshot _okunanUser =
        await FirebaseFirestore.instance.doc('users/${user.userID}').get();

    Map<String, dynamic>? _okunanUserBilgileriMap =
        _okunanUser.data() as Map<String, dynamic>?;

    MyUser _okunanUserNesnesi = MyUser.fromMap(_okunanUserBilgileriMap!);
    debugPrint('okunan user nesnesi :' + _okunanUserNesnesi.toString());
    return true;
  }

  @override
  Future<MyUser?> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection("users").doc(userID).get();
    Map<String, dynamic>? _okunanUserBilgileriMap =
        _okunanUser.data() as Map<String, dynamic>?;
    if (_okunanUserBilgileriMap != null) {
      MyUser _okunanUserNesnesi = MyUser.fromMap(_okunanUserBilgileriMap);
      debugPrint('okunan usrer:' + _okunanUserNesnesi.toString());
      return _okunanUserNesnesi;
    }
    return null;
  }

  @override
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var users = await _firebaseDB
        .collection('users')
        .where('userName', isEqualTo: yeniUserName)
        .get();
    if (users.docs.length >= 1) {
      return false;
    } else {
      await _firebaseDB
          .collection("users")
          .doc(userID)
          .update({'userName': yeniUserName});
      return true;
    }
  }
}
