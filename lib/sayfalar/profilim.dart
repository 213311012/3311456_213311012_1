// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sayfalar/oturum_acma_sayfasi.dart';

import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:gezi_uygulamam/widgets/oturum_acma_butonlari.dart';
import 'package:gezi_uygulamam/widgets/platform_duyarl%C5%9Fi_diyalog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gezi_uygulamam/sabitler/renkler.dart' as myColors;

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  TextEditingController? _controllerUserName;
  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    _controllerUserName?.text = _userModel.user!.userName!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColors.guzelMavi,
          title: const Text('Profilim'),
          actions: [
            IconButton(
                onPressed: () {
                  _cikisIcinOnayIste(context);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 170,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Kameradan Çek'),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Galeriden Seç'),
                                onTap: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/8_avatar-512.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userModel.user!.email,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Emailiniz',
                      hintText: 'email',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  decoration: const InputDecoration(
                      labelText: 'User Name',
                      hintText: 'User',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: DateFormat('yyyy-MM-dd HH:mm')
                      .format(_userModel.user?.createdAt ?? DateTime.now()),
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Son Giriş',
                      hintText: 'Son Giriş',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OturumAcmaButton(
                  butonText: 'Değişikleri Kaydet',
                  butonColor: Colors.pink,
                  textColor: Colors.white,
                  radius: 18,
                  butonIcon: const Icon(Icons.update),
                  onPressed: () {
                    _userNameGuncelle(context);
                  },
                ),
              )
            ],
          )),
        ));
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    if (sonuc) {
    //bool sonuc = await _userModel.signOut();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OturumAc()));
    }
    return sonuc;
  }

  Future _cikisIcinOnayIste(BuildContext context) async {
    final sonuc = await PlatformDuyarliAlertDialog(
      baslik: 'Emin Misiniz ?',
      icerik: 'Oturumu Kapatıyorsunuz !',
      anaButonYazisi: 'Evet',
      iptalButonYazisi: 'Vazgeç',
    ).goster(context);
    if (sonuc == true) {
      _cikisYap(context);
    }
  }

  void _userNameGuncelle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_userModel.user!.userName != _controllerUserName?.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user!.userID, _controllerUserName!.text);

      if (updateResult == true) {
        PlatformDuyarliAlertDialog(
          baslik: "Başarılı",
          icerik: "Username değiştirildi",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      } else {
        _controllerUserName?.text = _userModel.user!.userName!;
        PlatformDuyarliAlertDialog(
          baslik: "Hata",
          icerik: "Username zaten kullanımda, farklı bir username deneyiniz",
          anaButonYazisi: 'Tamam',
        ).goster(context);
      }
    }
  }
}
