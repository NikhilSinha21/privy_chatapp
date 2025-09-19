import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

class UserProfile extends StatelessWidget{
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: messagebackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Container(
               margin: const EdgeInsets.only(top: 10,right: 10) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back,color: Color.fromARGB(255, 255, 255, 255),)),
              
                  //App Name
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(TextNames.appname,
                    style: AppTextStyle.appname,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            
          SingleChildScrollView(
              padding:  const EdgeInsets.only(left: 10,right: 10,top:10),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(height: 25,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    
                     CircleAvatar(
                        radius: 45, 
                      child:   Icon(Icons.person,size: 45,),),
                      
                       SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(TextNames.username,style: AppTextStyle.username),
                        Text(TextNames.userid,style: AppTextStyle.clickOn),

                       
                        ]),
                        Spacer(),
                         Icon(Icons.more_vert,color: Colors.white,),

               ],
                ),
                const SizedBox(height: 35,),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 10,),
                const Text(TextNames.settings,style: AppTextStyle.appname),
                const SizedBox(height: 35,),
                
                const Text(TextNames.backgroundcolorchange,style: AppTextStyle.clickOn),
                const SizedBox(height: 10,),
                const Text(TextNames.fontchange,style: AppTextStyle.clickOn),
                const SizedBox(height: 10,),
                const Text(TextNames.textcolorchange,style: AppTextStyle.clickOn),
              ],
              ),
            ),
           const  Spacer(),
            const Center(
              child: Column(
                children: [
              Text(TextNames.appname,style: AppTextStyle.button,),
              Text(TextNames.creater,style: AppTextStyle.clickOn,),],),
            ),
              const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}