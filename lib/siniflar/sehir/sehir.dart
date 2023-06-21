import 'package:gezi_uygulamam/siniflar/foods.dart';
import 'package:gezi_uygulamam/siniflar/places.dart';

class Sehir {
  String adi;
  String aciklama;
  String ulke;
  int id;
  List<Places> yerler;
  List<Foods> yemekler;


  int type;
  Sehir({
    required this.adi,
    required this.aciklama,
    required this.ulke,
    required this.id,
    required this.yerler,
    required this.yemekler,
    required this.type,
  });

 

  @override
  String toString() {
    return 'Sehir(adi: $adi, aciklama: $aciklama, ulke: $ulke, id: $id, yerler: $yerler, yemekler: $yemekler, type: $type)';
  }
}
