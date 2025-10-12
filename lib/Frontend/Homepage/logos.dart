
import 'package:flutter/material.dart';
import 'package:Privy/Frontend/Things/color.dart';

// copy logo made
class CopyLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
  return   Container(
    padding: const EdgeInsets.all(1),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      backgroundColor:backgroundColor,
      radius: 25, 
      
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
             bottom: 12,
            left: 14.5,
            child: Container(
              
              height: 24,
              width: 17,
              decoration: BoxDecoration(
                color: backgroundColor,
               borderRadius: BorderRadius.circular(4),
               border: Border.all(
                width: 1.2,
                color: Colors.white
               )
              ),
              
            ),
          ),
      
            Positioned(
            bottom: 15,
            left: 18.5,
            child: Container(
              
              height: 24,
              width: 17,
              decoration: BoxDecoration(
                color: backgroundColor,
               borderRadius: BorderRadius.circular(4),
               border: Border.all(
                width: 1.2,
                color: Colors.white
               )
              ),
              
            ))
        ],
      ),
    ),
  );
  }
}


class deleteLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
  return   Container(
    padding: const EdgeInsets.all(1),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      backgroundColor:backgroundColor,
      radius: 25, 
      
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
             top: 16,
            child: Container(
              
              height: 22,
              width: 20,
              decoration: const BoxDecoration(
                color: backgroundColor,
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3),bottomRight: Radius.circular(3)),
               border: Border(
                 left: BorderSide(width: 1.2,color: Colors.white),
                 right: BorderSide(width: 1.2,color: Colors.white),
                 bottom: BorderSide(width: 1.2,color: Colors.white),
               )
              ),
              
              
            ),
          ),
      
           Positioned(
            top: 15,
            child: Container(
            height: 2,
            width: 24,
            color: backgroundColor,
           ),
           ) ,

           Positioned(
            top: 14,
            child: Container(
            height: 2,
            width: 23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25)
            ),
           ),
           ) ,

           Positioned(
            top: 13,
            child: Container(
            height: 2,
            width: 5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(2),topRight: Radius.circular(2))
            ),
           ),
           ) 
        ],
      ),
    ),
  );
  }
}


