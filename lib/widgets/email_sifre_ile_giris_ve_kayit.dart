// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:gezi_uygulamam/widgets/hatalar.dart';
import 'package:gezi_uygulamam/widgets/oturum_acma_butonlari.dart';
import 'package:gezi_uygulamam/widgets/platform_duyarl%C5%9Fi_diyalog.dart';
import 'package:provider/provider.dart';
import 'package:gezi_uygulamam/sabitler/renkler.dart' as myColors;
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FormType { Register, Login }

class EmailveSifreIleGiris extends StatefulWidget {
  const EmailveSifreIleGiris({super.key});

  @override
  State<EmailveSifreIleGiris> createState() => _EmailveSifreIleGirisState();
}

class _EmailveSifreIleGirisState extends State<EmailveSifreIleGiris> {
  String _email = '', _sifre = '';
  String _butonText = '', _linkText = '';
  var _formType = FormType.Login;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.Login ? 'Giriş Yap' : ' Kayıt ol';
    _linkText = _formType == FormType.Login
        ? 'Hesabınız yok mu ? Kayıt olun'
        : 'Hesabınız var mı ? Giriş Yapın';

    final _userModel = Provider.of<UserModel>(context,
        listen:
            true); 

    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 1), () {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColors.guzelMavi,
          title: Text('Giris / Kayıt  ',style: GoogleFonts.ubuntu(),)),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: _userModel.emailHataMesaji != null
                              ? _userModel.emailHataMesaji
                              : null,
                          prefixIcon: Icon(Icons.mail),
                          hintText: 'Email',
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      onSaved: (String? girilenEmail) {
                        _email = girilenEmail!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          errorText: _userModel.sifrehataMesaji != null
                              ? _userModel.sifrehataMesaji
                              : null,
                          prefixIcon: Icon(Icons.password_rounded),
                          hintText: 'Şifre',
                          labelText: 'Şifre',
                          border: OutlineInputBorder()),
                      onSaved: (String? girilensifre) {
                        _sifre = girilensifre!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    OturumAcmaButton(
                      butonText: _butonText,
                      butonColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      radius: 20,
                      butonIcon: Icon(Icons.forward),
                      onPressed: () => _fromSubmit(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () => _degistir(), child: Text(_linkText))
                  ]),
                ),
              ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _fromSubmit() async {
    _formKey.currentState?.save();
    debugPrint('email :' + _email + '        sifre:' + _sifre);
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_formType == FormType.Login) {
      try {
        MyUser? _girisYapanUser =
            await _userModel.signInWithEmailandPassword(_email, _sifre);
        if (_girisYapanUser != null)
          debugPrint('oturum açan user id:' + _girisYapanUser.userID);
      } on FirebaseAuthException catch (e) {
         PlatformDuyarliAlertDialog(
                baslik: 'Oturum açma Hatası',
                icerik: Hatalar.goster(e.code),
                anaButonYazisi: 'Tamam').goster(context);
      }
    } else {
      try {
        MyUser? _olusturulanUser =
            await _userModel.createUserWithEmailandPassword(_email, _sifre);
        if (_olusturulanUser != null)
          debugPrint('oturum açan user id:' + _olusturulanUser.userID);
      } on FirebaseAuthException catch (e) {
        PlatformDuyarliAlertDialog(
                baslik: 'Kullanıcı Oluşturma Hatası',
                icerik: Hatalar.goster(e.code),
                anaButonYazisi: 'Tamam').goster(context);
          }
    
      }
    }
  

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }
}
