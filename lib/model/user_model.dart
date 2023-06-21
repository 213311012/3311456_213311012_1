import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String userID;
  String email;
  String? userName;
  String? profilURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? seviye;

  MyUser({
    required this.userID,
    required this.email,
    this.userName,
    this.profilURL,
    this.createdAt,
    this.updatedAt,
    this.seviye,
  });

  Map<String, dynamic> toMap() {
     
    return {
      'userID': userID,
      'email': email,
      'userName': userName ?? email.substring(0, email.indexOf('@')) + randomSayiUret(),
      'profilURL': profilURL ,
      'createdAT': createdAt ?? FieldValue.serverTimestamp(),
      'updateAt': updatedAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt =
            (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        updatedAt =
            (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        seviye = map['seviye'];

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye}';
  }

  String randomSayiUret() {
    int rastegeSayi = Random().nextInt(99999);
    return rastegeSayi.toString();
  }
}
