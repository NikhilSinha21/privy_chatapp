import 'package:flutter/material.dart';

class Settingbuttons{

  static Widget  text(String text,double size){

    return Text(text,
                style:  TextStyle(
                color: Colors.white,
                fontSize: size,
              ),
    );
  }

  static Widget  textsupportcolor(String text,double size,Color color , FontWeight fontweight){

    return Text(text,
                style:  TextStyle(
                color: color,
                fontSize: size,
                fontWeight: fontweight
              ),
    );
  }
}