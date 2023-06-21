
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sabitler/rota_islemleri.dart';
import 'package:gezi_uygulamam/sayfalar/404screen.dart';
import 'package:gezi_uygulamam/sayfalar/acilis_sayfasi.dart';
import 'package:gezi_uygulamam/sayfalar/places_detay.dart';
import 'package:gezi_uygulamam/sayfalar/sehir_detay_sayfasi.dart';
import 'package:gezi_uygulamam/sayfalar/weather_screen.dart';
import 'package:gezi_uygulamam/siniflar/sehir/sehir.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    print("****");
    print(settings.arguments);
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (context) => AcilisSayfasi());
      case cityDetailRoute:
        return MaterialPageRoute(
            builder: (context) => CityDetail(
                  data: settings.arguments as Sehir,
                ));
      case placesDetailRoute:
        return MaterialPageRoute(
            builder: (context) => PlacesDetail(
                  yerData: (settings.arguments as List)[0],
                  sehirData: (settings.arguments as List)[1]
                ));
     
      case weatherScreen:
        return MaterialPageRoute(
            builder: (context) => WeatherScreen(
                  data: settings.arguments as Sehir,
                ));
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
} 
