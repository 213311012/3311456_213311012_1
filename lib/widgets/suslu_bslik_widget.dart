import 'package:flutter/material.dart';
import 'package:gezi_uygulamam/sabitler/renkler.dart' as myColors;


class ContainerWithTitle extends StatelessWidget {
  final Widget widget;
  final String title;
  final double? containerHeight;
  final double? titleSize;

  const ContainerWithTitle({super.key, required this.widget, required this.title,   this.containerHeight, this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: myColors.rengim,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              height: 5,
            ),
            Container(
              height: this.containerHeight,
              padding: EdgeInsets.only(bottom: 5),
              child: widget,
            )
          ],
        ),
      ),
    );
  }
}
