
import 'package:flutter/material.dart';
import 'package:Privy/Frontend/Things/color.dart';

// copy logo made
class CopyLogo extends StatelessWidget{
  const CopyLogo({super.key});

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
      
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          color: backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                 bottom: 0,
                left: 0.3,
                child: Container(
                  
                  height: 17,
                  width: 15.5,
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
                top: 0,
                right: 0.3,
                child: Container(
                  
                  height: 17,
                  width: 15.5,
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
      ),
    ),
  );
  }
}

// delete logo 
class DeleteLogo extends StatelessWidget{
  const DeleteLogo({super.key});

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
      
      child: Container(
        height: 20,
        width: 20,
        color: backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
               bottom: 0,
              child: Container(
                
                height: 15,
                width: 15.8,
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
              top: 1.6,
              child: Container(
              height: 3.5,
              width: 24,
              color: backgroundColor,
             ),
             ) ,
        
             Positioned(
              top: 1.3,
              child: Container(
              height: 1.4,
              width: 19.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
             ),
             ) ,
        
             Positioned(
              top: 0.1,
              child: Container(
              height: 2,
              width: 4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(2),topRight: Radius.circular(2))
              ),
             ),
             ) 
          ],
        ),
      ),
    ),
  );
  }
}


// share logo made
class ShareLogo extends StatelessWidget{
  const ShareLogo({super.key});
  
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
      
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          color: backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  
                  height: 19.8,
                  width: 19.6,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                   borderRadius: BorderRadius.circular(3),
                   border: Border.all(
                    width: 1.2,
                    color: Colors.white
                   )
                  ),
                  
                ),
              ),
          
          
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  
                  height: 10,
                  width: 10,
                  color: backgroundColor,
                  
                ),
              ),
          
          
             Positioned(
                top: 0,
                right: 0,
                child: Container(
          
                  height: 5.8,
                  width: 5.7,
                  
                  decoration: BoxDecoration(
                    color: backgroundColor,
                   borderRadius: const BorderRadius.only(topRight: Radius.circular(1)),
                   border: Border.all(
                    width: 1.2,
                    color: Colors.white
                   )
                  ),
                ),
              ),
          
               Positioned(
                top: 1.3,
                right: 1.3,
                child: Container(
                  
                  height: 10,
                  width: 10,
                  
                  decoration: BoxDecoration(
                    color: backgroundColor,
                   borderRadius: const BorderRadius.only(topRight: Radius.circular(3)),
                   border: Border.all(
                    width: 1.2,
                    color: backgroundColor
                   )
                  ),
                ),
              ),
               
          
               Positioned(
               bottom: 4.6,
               left: 12.4,
                 child: Transform.rotate(
                  angle: 0.8,
                   child: Container(
                    height: 17,
                    width: 1.2,
                    color: Colors.white,
                   ),
                 ),
               )
            ],
          ),
        ),
      ),
    ),
  );
  }
}
