// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:gezi_uygulamam/widgets/email_sifre_ile_giris_ve_kayit.dart';
import 'package:gezi_uygulamam/widgets/oturum_acma_butonlari.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OturumAc extends StatelessWidget {
  const OturumAc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/trvy.jpg',
              ),
              fit: BoxFit.cover)),
    
     child:Scaffold(
     
      backgroundColor: const Color.fromARGB(0, 62, 139, 139),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Oturum Açın',
                    textAlign: TextAlign.center, style:  GoogleFonts.ubuntu(fontSize: 32,fontWeight:FontWeight.bold)),
                const SizedBox(
                  height: 18,
                ),
                OturumAcmaButton(
                    butonText: ' Google İle Giriş Yap ',
                    butonColor: Colors.white.withOpacity(0.6),
                    textColor: Colors.black87,
                    radius: 24,
                    butonIcon: Image.asset('assets/images/google-logo.png'),
                    onPressed: () => _googleIleGiris(context)),
                const SizedBox(
                  height: 10,
                ),
              
             
                OturumAcmaButton(
                  butonText: ' Email İle Giriş Yap / Kayıt ',
                  butonColor: Colors.purple.withOpacity(0.8),
                  textColor: Colors.black,
                  radius: 24,
                  butonIcon: const Icon(Icons.email),
                  onPressed: () => _emailveSifreGiris(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                OturumAcmaButton(
                    butonText: ' Misafir Girişi ',
                    butonColor: Colors.teal.withOpacity(0.8),
                    textColor: Colors.black,
                    radius: 24,
                    butonIcon: const Icon(Icons.supervised_user_circle),
                    onPressed: () => _misafirGirisi(context)),
                    const SizedBox(height: 25,)
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    MyUser? _user = await _userModel.singInAnonymously();

    debugPrint('oturum açan user id: ' + _user!.userID.toString());
  }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    MyUser? _user = await _userModel.signInWithGoogle();
    if (_user != null)
      debugPrint('oturum açan user id: ' + _user.userID.toString());
  }

  void _emailveSifreGiris(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EmailveSifreIleGiris(),
    ));
  }
}
