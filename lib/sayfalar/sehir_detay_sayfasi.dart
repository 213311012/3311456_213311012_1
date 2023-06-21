// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sayfalar/foods.dart';
import 'package:gezi_uygulamam/sayfalar/weather_screen.dart';
import 'package:gezi_uygulamam/siniflar/sehir/sehir.dart';
import 'package:gezi_uygulamam/widgets/places_card_widget.dart';
import 'package:gezi_uygulamam/widgets/suslu_bslik_widget.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:gezi_uygulamam/sabitler/renkler.dart' as myColors;


class CityDetail extends StatefulWidget {
  final Sehir data;
  const CityDetail({super.key,  required this.data});

  @override
  _CityDetailState createState() => _CityDetailState();
}
class _CityDetailState extends State<CityDetail> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:myColors.appbar,
          title: Text('Yeni Rota :  ${widget.data.adi}'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.explore)),
              Tab(icon: Icon(Icons.cloud)),
              Tab(icon: Icon(Icons.fastfood)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Content(data: widget.data),
            WeatherScreen(
              data: widget.data,
            ),
           /*  CityCommentsScreen(
              sehirData: widget.data,
            ), */
            Foods(
              sehirData: widget.data,
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final Sehir data;

  Content({required this.data});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  void _launchMapsUrl(String addr) async {
    print(addr.replaceAll(' ', '+'));
    final url =
        'https://www.google.com/maps/search/${addr.replaceAll(' ', '+')}/';
    await launch(url);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                child: Hero(
                  tag: 'city-img-${widget.data.id}',
                  child: GestureDetector(
                    onScaleStart: (ScaleStartDetails details) {
                      print(details);
                      _previousScale = _scale;
                      setState(() {});
                    },
                    onScaleUpdate: (ScaleUpdateDetails details) {
                      print(details);
                      _scale = _previousScale * details.scale;
                      setState(() {});
                    },
                    onScaleEnd: (ScaleEndDetails details) {
                      print(details);

                      _previousScale = 1.0;
                      setState(() {});
                    },
                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform:
                            Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                        child: ClipRRect(
                          // ignore: sort_child_properties_last
                          child: Image.asset(
                            'assets/images/${widget.data.type == 1 ? 'Yurtici' : 'Yurtdisi'}/${widget.data.adi.toLowerCase()}.jpg',
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 170,
                  left: 16,
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          widget.data.adi,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          widget.data.ulke,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  )),
              Positioned(
                top: 180,
                right: 16,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _launchMapsUrl(widget.data.adi);
                      },
                      child: CircleAvatar(
                        backgroundColor:myColors.appbar,
                        child: Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),

                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ContainerWithTitle(
            title: 'Tanıtım',
            titleSize: 25,
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(widget.data.aciklama),
              ),
            ),
          ),
          ContainerWithTitle(
            
            containerHeight: 200,
            
            title: 'Gezilecek Yerler',
            titleSize: 25,
            widget: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.data.yerler
                  .map(
                    (e) => PlacesCard(
                      placeData: e,
                      sehirData: widget.data, 
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
