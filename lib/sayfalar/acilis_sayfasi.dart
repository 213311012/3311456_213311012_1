
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sayfalar/anasayfam.dart';
import 'package:gezi_uygulamam/sayfalar/oturum_acma_sayfasi.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class AcilisSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _userModel = Provider.of<UserModel>(context,
        listen:
            true); 

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return OturumAc();
      } else {
        return AnaSayfa();
        //HomePage(user: _userModel.user!);
      }
    } else {
      // ignore: prefer_const_constructors
      return Scaffold(
        // ignore: prefer_const_constructors
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
