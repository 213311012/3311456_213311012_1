import 'package:flutter/material.dart';

class OturumAcmaButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const OturumAcmaButton({
    Key? key,
    required this.butonText,
    required this.butonColor,
    required this.textColor,
    required this.radius,
     this.yukseklik =50 ,
    required this.butonIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(butonColor),
        
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(onPressed: onPressed, icon: butonIcon),
          Text(
           butonText,
            style: TextStyle(color: textColor),
          ),
          Container(
            width: 35,
          )
        ],
      ),
    );
  }
}
