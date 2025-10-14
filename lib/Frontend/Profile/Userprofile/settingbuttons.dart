import 'package:Privy/Frontend/Things/color.dart';
import 'package:flutter/material.dart';

class Settingbuttons{

  static Widget returnbutton(BuildContext context){
    return IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Image.asset(
                          "assets/images/backward.png",
                          height: 45,
                          width: 45,
                        ),
                      );
  }

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


  static Widget  textfield(String hinttext,Color color,int maxlength,TextEditingController? controller,){

    return TextField(
                controller: controller,
                maxLength: maxlength,
                decoration: InputDecoration(
                  labelText: hinttext,
                  
                  labelStyle: const TextStyle(
                  color: messagecontainerColor,
                  fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: messagecontainerColor),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: messagecontainerColor),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  

                ),
                style:  TextStyle(
                color: color,
                fontSize: 16,
                
              ),
    );
  }
}

