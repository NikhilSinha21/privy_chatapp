
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

enum SampleItem { changeName, changeProfilePic }
class MenuGlass extends StatefulWidget{
  const MenuGlass({super.key});

  @override
  State<MenuGlass> createState() => _MenuGlassState();
}

class _MenuGlassState extends State<MenuGlass> {
   bool _isMenuOpen = false;
  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }
  @override
  Widget build(BuildContext context) {
  return  Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
                       onTap: toggleMenu,
                      child: Image.asset("assets/images/Threedot.png",height: 24, width: 24,  )
                      ),
      if(_isMenuOpen)
       Positioned(
  top: 0,
  right: 25,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4,sigmaY: 4),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10), // add padding for spacing
        decoration: BoxDecoration(
          color: glass,
          borderRadius: BorderRadius.circular(12),
          
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 188, 188, 188),
          ) // optional rounded corners
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(TextNames.changeusername , style: AppTextStyle.PopupMenuItem,),
             SizedBox(height: 10,),
             Text(TextNames.changeProfilePic , style: AppTextStyle.PopupMenuItem,),
          ],
        ),
      ),
    ),
  ),
),

    

                                
    ],
  );
                       
  }
   
}