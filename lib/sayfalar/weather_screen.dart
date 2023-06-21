import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/servis/weather_Api.dart';
import 'package:gezi_uygulamam/siniflar/sehir/sehir.dart';
import 'package:gezi_uygulamam/siniflar/weather.dart';
import 'package:gezi_uygulamam/widgets/suslu_bslik_widget.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  final Sehir data;

  const WeatherScreen({required this.data});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Weather>? havaDurumu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    havaDurumu = getWeather(widget.data.adi);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: FutureBuilder(
            future: havaDurumu,
            builder: (context, AsyncSnapshot<Weather> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/${widget.data.type == 1 ? 'Yurtici' : 'Yurtdisi'}/${widget.data.adi.toLowerCase()}.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    // ignore: unnecessary_string_interpolations
                                    '${DateFormat('dd.MM.yyyy').format(DateTime.now())}'),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${snapshot.data?.temp} °C',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 45),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  '${toBeginningOfSentenceCase(snapshot.data?.description)}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.white,
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      // ignore: unnecessary_string_interpolations
                                      '${widget.data.adi}',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            ContainerWithTitle(
                              title: 'Detay',
                              widget: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherPropsListWidget(
                                      title: 'Bulut',
                                      icon: Icons.cloud,
                                      value:
                                          // ignore: prefer_interpolation_to_compose_strings
                                          '%' + snapshot.data!.cloud.toString(),
                                    ),
                                    WeatherPropsListWidget(
                                      title: 'Nem',
                                      icon: Icons.opacity,
                                      value: '%' +
                                          snapshot.data!.humidity.toString(),
                                    ),
                                    WeatherPropsListWidget(
                                      title: 'Basınç',
                                      icon: Icons.circle,
                                      value: ((snapshot.data!.pressure * 0.001)
                                          .toStringAsFixed(2)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ContainerWithTitle(
                              title: 'Detay',
                              widget: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherPropsListWidget(
                                      title: 'Rüzgar',
                                      icon: Icons.waves,
                                      value:
                                          snapshot.data!.windSpeed.toString() +
                                              ' m/s',
                                    ),
                                    WeatherPropsListWidget(
                                      title: 'Rüzgar Yönü',
                                      icon: Icons.explore,
                                      value: snapshot.data!.windDeg.toString() +
                                          ' deg',
                                    ),
                                    WeatherPropsListWidget(
                                      title: 'Görüş',
                                      icon: Icons.visibility,
                                      value: (snapshot.data!.visibility * 0.001)
                                              .toStringAsFixed(0) +
                                          ' km',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}

class WeatherPropsListWidget extends StatelessWidget {
  final String title;
  final icon;
  final String value;
  final double iconSize = 45;
  final double valueTextSize = 20;

  WeatherPropsListWidget({required this.title, this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Text(
          '$value',
          style: TextStyle(fontSize: valueTextSize),
        )
      ],
    );
  }
}
