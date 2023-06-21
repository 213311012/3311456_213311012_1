import 'package:flutter/cupertino.dart';
import 'package:gezi_uygulamam/widgets/tab_items.dart';

class MyCustomButonNavigasyon extends StatelessWidget {
  const MyCustomButonNavigasyon({
    Key? key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.sayfaOlusturucu,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem,Widget> sayfaOlusturucu;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        _navItemOlustur(TabItem.Planlarim),
        _navItemOlustur(TabItem.Hakkimizda),
        _navItemOlustur(TabItem.Profil),
      ],
      onTap: (index) => onSelectedTab(TabItem.values[index]),),
      tabBuilder: (context, index) {
        final gosterilecekItem =TabItem.values[index];
        return CupertinoTabView(
          builder: (context) {
            return sayfaOlusturucu[gosterilecekItem]!;
          }
          
        );
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];

    return BottomNavigationBarItem(
        icon: Icon(olusturulacakTab?.icon), label: olusturulacakTab?.title);
  }
}
