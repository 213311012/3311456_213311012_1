class Weather{
  int temp;
  String description;
  String name;
  double windSpeed;
  int cloud;
  int pressure;
  int humidity;
  int visibility;
  int windDeg;

  Weather({required this.temp, required this.description, required this.name, required this.windSpeed, required this.cloud, required this.pressure, required this.humidity, required this.visibility, required this.windDeg});

  factory Weather.fromJson(Map json){
    return Weather(
        temp: (json['main']['temp'] is int) ? json['main']['temp'] : int.parse(json['main']['temp'].toStringAsFixed(0)),
        description: json['weather'][0]['description'],
        name: json['name'],
        windSpeed: json['wind']['speed'],
        cloud: json['clouds']['all'],
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        visibility: json['visibility'],
        windDeg: json['wind']['deg']
    );
  }
}