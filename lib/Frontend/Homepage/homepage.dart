
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/background.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/message.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

class Homepage extends StatelessWidget{
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
    backgroundColor: Colors.black,
    
    body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
         // here i want to put the background() so it doesn't change and went back to behind 
         // 
        child: Stack(
        children: [
        
        const Positioned.fill(
                  child: Background(),
                ),
          
        
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10,left: 23,right: 10,bottom: 20) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(TextNames.appname,
                    style: AppTextStyle.appname,
                    
                    ),
                    const Spacer(),
                     GestureDetector(
                      onTap: () {
                        Navigator.pushNamed((context),'/userprofile');
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 5,right:30),
                        child: const UserAvatar()),)
                      
                    
                  ],
                ),
              ),
              
             Expanded(
              child: ListView.builder( 
                itemCount: 20,
                itemBuilder: (context,index){
                 return  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                
                  
                      Container(
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 5,right:10),
                              child: const UserAvatar()),
                            
                            const Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    UserName(),
                                    Time(),
                                  ],
                                ),
                                
                                SizedBox(height: 6,),
                                
                              ],
                            ),
                            const Spacer(),
                         Container ( 
                          padding: const EdgeInsets.only(top: 20,right:10),
                          child:  Image.asset("assets/images/Threedot.png",height: 24,width: 24,),),
                          ],
                        ),
                      ),
                      const Stack(
                        clipBehavior: Clip.none,
                        children: [
                         Message(),
                      Positioned(
                            left: 40, // moves it to the left
                            bottom: -22, // you can adjust vertical position
                            child: Reaction(),
                          ),
                      ],),
                     
                      const SizedBox(height: 50,)
                   ],
                 );
                 
                }
              )),
                
             
              Container(
                margin: const EdgeInsets.only(bottom: 2,top: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 6,),
                    Expanded(
                      child: TextField(
                        
                             decoration: InputDecoration(
                              hintText: TextNames.messagehint,
                              filled: true,
                              fillColor: messagecontainerColor,
                              hintStyle:  AppTextStyle.hint,
                              border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(50),
                               borderSide: BorderSide.none,
                               ),
                               contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              ),
                             ),
                    ),
                         const SizedBox(width: 5,),
                           Image.asset("assets/images/forward.png",height: 40,width: 40,)
                  ],
                ),
              ),
            ],
          ),
        ],
                  ),
      ),
    ),
    ); 

  }
}