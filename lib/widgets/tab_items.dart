import 'package:flutter/cupertino.dart';

enum TabItem { Planlarim, Hakkimizda, Profil }

class TabItemData {
  final String title;
  final IconData icon;
  TabItemData({
    required this.title,
    required this.icon,
  });

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Planlarim:
        TabItemData(title: 'Planlarım', icon: CupertinoIcons.calendar_circle_fill),
        TabItem.Hakkimizda:
        TabItemData(title: 'Hakkımızda', icon: CupertinoIcons.book_circle_fill),
        TabItem.Profil:
        TabItemData(title: 'Profil', icon: CupertinoIcons.person_2_fill),


  };
}
