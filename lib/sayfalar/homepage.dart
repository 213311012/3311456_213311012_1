// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/model/user_model.dart';
import 'package:gezi_uygulamam/sayfalar/planPage/planlarim.dart';
import 'package:gezi_uygulamam/sayfalar/profilim.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:gezi_uygulamam/widgets/custom_button_navi.dart';
import 'package:gezi_uygulamam/widgets/tab_items.dart';
import 'package:provider/provider.dart';

import 'hakkimizda.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
     this.user,
  }) : super(key: key);
  final MyUser? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Profil;
  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Planlarim: Planlarim(),
      TabItem.Hakkimizda: Hakkimizda(),
      TabItem.Profil: Profil()
    };
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final _userModel = Provider.of<UserModel>(context);

    return Container(
        child: MyCustomButonNavigasyon(
            sayfaOlusturucu: tumSayfalar(),
            currentTab: _currentTab,
            onSelectedTab: (secilenTab) {
              setState(() {
                _currentTab = secilenTab;
              });
              debugPrint('seçilen tab item:' + secilenTab.index.toString());
            }));
  }
}
