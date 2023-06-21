import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/siniflar/places.dart';
import 'package:gezi_uygulamam/siniflar/sehir/sehir.dart';
import 'package:gezi_uygulamam/sabitler/rota_islemleri.dart' as myRouteNames;


class PlacesCard extends StatelessWidget {
  final Places placeData;
  final Sehir sehirData;
  final bool? haveText;
  final bool? isClickable;
  
 const PlacesCard({
    Key? key,
    required this.placeData,
    required this.sehirData,
    this.haveText,
    this.isClickable,
  }) : super(key: key);
  

  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            if(isClickable == null){
              Navigator.pushNamed(context, myRouteNames.placesDetailRoute, arguments:[placeData, sehirData]);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage(
                    'assets/images/${sehirData.type == 1 ? 'Yurtici' : 'Yurtdisi'}/Mekan/${sehirData.adi}/${placeData.fotograf}.jpg'),
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                right: 16,
                left: 16,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        haveText == null ? '${placeData.adi}' : '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
