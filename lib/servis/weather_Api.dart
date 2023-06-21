import 'package:gezi_uygulamam/sabitler/api/api.dart' as api ;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gezi_uygulamam/siniflar/weather.dart';

Future<Weather> getWeather(String cityName) async{
  String myUri = 'http://api.openweathermap.org/data/2.5/weather?q=${cityName.toString()}&appid=${api.APIKey}&units=${api.units}&lang=${api.lang}';
  final response = await http.get(Uri.parse(myUri));
  if(response.statusCode == 200){
    return Weather.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}