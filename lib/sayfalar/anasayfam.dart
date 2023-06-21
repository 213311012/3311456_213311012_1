import 'package:gezi_uygulamam/sabitler/renkler.dart' as myColors;
import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sayfalar/homepage.dart';
import 'package:gezi_uygulamam/siniflar/sehir/data.dart';
import 'package:gezi_uygulamam/view_modeller/user_model.dart';
import 'package:gezi_uygulamam/widgets/sehir_card_widget.dart';
import 'package:gezi_uygulamam/widgets/suslu_bslik_widget.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class AnaSayfa extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool isLogged = false;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myColors.rengim,
        elevation: 0,
        title: Text(
          ' ${_userModel.user!.userName}',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        //leading: Icon(Icons.explore),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
              icon: const Icon(Icons.person))
        ],
        // ignore: prefer_const_constructors
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  // ignore: unnecessary_new
  final Data sehirData = new Data();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                //BorderRadius.only(
                ///  bottomLeft: Radius.circular(15),
                // bottomRight: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/Background/logomuz1.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WavingHandEmojiWidget(),
                      const Text(
                        'Merhaba,  \nBugün Nereye Gidiyoruz ?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
                ContainerWithTitle(
                  containerHeight: 200,
                  title: 'Yurtiçi',
                  titleSize: 22,
                  widget: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sehirData.yurtici
                        .sortedBy((element) => element.adi)
                        .map((item) => SehirCard(
                              sehirData: item,
                            ))
                        .toList(),
                  ),
                ),
                ContainerWithTitle(
                  containerHeight: 200,
                  title: 'Yurtdışı',
                  titleSize: 22,
                  widget: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sehirData.yurtdisi
                        .sortedBy((element) => element.adi)
                        .map((item) => SehirCard(sehirData: item))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class WavingHandEmojiWidget extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WavingHandEmojiWidgetState createState() => _WavingHandEmojiWidgetState();
}

class _WavingHandEmojiWidgetState extends State<WavingHandEmojiWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );
    _animation = Tween(
      begin: Offset.zero,
      // ignore: prefer_const_constructors
      end: Offset(1, 0.5),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
    _controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _animation!,
        child: Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/images/planes.png')));
  }
}
