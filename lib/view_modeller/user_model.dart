// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/depo/user_repository.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/servis/auth_base.dart';
import 'package:gezi_uygulamam/servis/bulucu.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  // stste kullanıcının verisi
  ViewState _state = ViewState.Idle;

  UserRepository _userRepository = locator<UserRepository>();
  MyUser? _user;
  String? emailHataMesaji;
  String? sifrehataMesaji;

  MyUser? get user => _user;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> singInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.singInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailandPassword(
      String email, String sifre) async {
    if (_emailsifrekontrolu(email, sifre)) {
      try{
        state = ViewState.Busy;
      _user =
          await _userRepository.createUserWithEmailandPassword(email, sifre);
      return _user;
      }finally{
      state = ViewState.Idle;

      }
    } else
      return null;
  }

  @override
  Future<MyUser?> signInWithEmailandPassword(String email, String sifre) async {
    try {
      if (_emailsifrekontrolu(email, sifre)) {
        state = ViewState.Busy;
        _user = await _userRepository.signInWithEmailandPassword(email, sifre);
        return _user;
      } else
        return null;
    } finally{

      state = ViewState.Idle;
    }
  }

  bool _emailsifrekontrolu(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifrehataMesaji = 'En az 6 karakter giriniz';
      sonuc = false;
    } else {
      sifrehataMesaji = null;
    }
    if (!email.contains('@')) {
      emailHataMesaji = 'Gecersiz email adresi';
      sonuc = false;
    } else {
      emailHataMesaji = null;
    }
    return sonuc;
  }

  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var sonuc = await _userRepository.updateUserName(userID, yeniUserName);
    if (sonuc) {
      _user!.userName = yeniUserName;
    }
    return sonuc;
  }
}
