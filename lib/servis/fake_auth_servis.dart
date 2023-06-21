// ignore_for_file: prefer_const_constructors

import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/servis/auth_base.dart';

class FakeAuthServis implements AuthBase {
  String userID = '123123123123';
  @override
  Future<MyUser> currentUser() async {
    return await Future.value(MyUser(userID: userID,email:'fakeuser@fake.com', userName: 'Anonim', createdAt: DateTime.now()
    ));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
    
  }
    @override
  Future<MyUser> singInAnonymously()async {
    return await Future.delayed(Duration(seconds: 2),()=> MyUser(userID: userID,email:'fakeuser@fake.com',userName: 'anonim' , createdAt: DateTime.now()));
  }
  
  @override
  Future<MyUser> signInWithGoogle() {
    throw UnimplementedError();
  }
  
  @override
  Future<MyUser> createUserWithEmailandPassword(String email, String sifre) {
    throw UnimplementedError();
  }
  
  @override
  Future<MyUser> signInWithEmailandPassword(String email, String sifre) {
    throw UnimplementedError();
  }

  
}
