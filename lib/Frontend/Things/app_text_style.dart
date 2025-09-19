import 'package:flutter/material.dart';
import 'color.dart';

class AppTextStyle {

    // Authentications
    static const TextStyle heading = TextStyle(
                color: backgroundColor,
                fontSize: 32,
                fontWeight:FontWeight.bold,
              );

    static const TextStyle hint =  TextStyle(
                    color:  hintColor,
                    fontSize: 20, 
                    );   


    static const TextStyle clickOn = TextStyle(
                     fontSize: 18,
                     color: Colors.white,
                     ); 

    static const TextStyle link = TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      );

    static const TextStyle button = TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight:FontWeight.bold,
              );


    // HomePage

    static const TextStyle appname = TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 28,
                fontWeight:FontWeight.bold,
              );  

   // UserProfile

   static const TextStyle username =  TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 24,
                fontWeight:FontWeight.bold,
              );  

  static const TextStyle reaction = TextStyle(
                     fontSize: 20,
                     color: Colors.white,
                     );                                
}

