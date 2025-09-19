import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/message.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

class Homepage extends StatelessWidget{
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
    backgroundColor: messagebackgroundColor,

    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 15) ,
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
                  child: const UserAvatar(),)

                
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
                    margin: const EdgeInsets.only(left: 15,right: 15,top: 35),
                    child: const Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserAvatar(),
                        SizedBox(width: 7,),
                        Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserName(),
                            Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Time(),
                                SizedBox(width: 6,),
                                Date(),
                              ],
                            ),
                            
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.more_vert,color: Colors.white,)
                      ],
                    ),
                  ),
                  const Message(),
                  
               ],
             );
             
            }
          )),

         
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: TextField(
                   obscureText: true,
                   decoration: InputDecoration(
                    hintText: TextNames.messagehint,
                    filled: true,
                    hintStyle:  AppTextStyle.hint,
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(15),
                     borderSide: BorderSide.none,
                     ),
                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              
                      suffixIcon: IconButton(
                            icon:  const Icon(Icons.send), // icon to show/hide
                            onPressed: () {
                              // add hide button working
                              // will be done later
                            },
                  ),
                    ),
                   ),
          ),
        ],
      ),
    ),
    ); 

  }
}