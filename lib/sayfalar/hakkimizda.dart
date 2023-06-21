import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/helpers/dosya_%C4%B1slemleri.dart';
import 'package:gezi_uygulamam/helpers/dosya_%C4%B1slemleri2.dart';
import 'package:gezi_uygulamam/sayfalar/grafik.dart';

class Hakkimizda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => grafik(),
                ),
              );
            },
            icon: Icon(Icons.insert_chart_outlined_sharp),
          ),
        ],
        title: const Text('Hakkımızda'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen MOBİL PROGRAMLAMA dersi kapsamında 213311012 öğrenci numaralı Numan GÜNDÜZ tarafından hazırlanmıştır.',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: Text('Dosya İşlemleri Sayfasına Git'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FileOperationsScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Dosya İşlemleri2 Sayfasına Git'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FileDownloadView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
