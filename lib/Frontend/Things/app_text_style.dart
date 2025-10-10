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

    static const TextStyle timedate = TextStyle(
                     fontSize: 12,
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
                fontSize: 34,
                fontFamily: 'IrishGrover',
              );  
    static const TextStyle setting = TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 34,
                fontFamily: 'SUSE_Mono',
              ); 
   // UserProfile

   static const TextStyle username =  TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight:FontWeight.bold,
              ); 

    static const TextStyle settingusername =  TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 23,
                fontWeight:FontWeight.bold,
              );            

   static const TextStyle message =  TextStyle(
                color: textcolor,
                //fontSize: 24,
                
                fontSize: 18,
              );  

     static const TextStyle PopupMenuItem =  TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                //fontSize: 24,
                fontWeight:FontWeight.bold,
                fontSize: 15,
              );    


                                

  static const TextStyle reaction = TextStyle(
                     fontSize: 9,
                     color: Colors.white,
                     );                                
}

