import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/backgroundforsetting.dart';
import 'package:privy_chat_chat_app/Frontend/Profile/Userprofile/menu_glass.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';


class UserProfile extends StatefulWidget{
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Stack(
           
          children: [
            
            const Backgroundforsetting(),
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
             
              Container(
                 margin: const EdgeInsets.only(top: 10,right: 10,left: 20) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon:  Image.asset("assets/images/backward.png",height: 45,width: 45,),),
                
                   const Spacer(),
                    //App Name
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Text(TextNames.appname,
                      style: AppTextStyle.appname,
                      ),
                    ),
                    
                  ],
                ),
              ),
              
            Expanded(
              child: SingleChildScrollView(
                  padding:  const EdgeInsets.only(left: 10,right: 10,top:10),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const SizedBox(height: 50,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        
                         CircleAvatar(
                            radius: 40, 
                            
                          backgroundImage:  AssetImage("assets/images/user_logo.png",),),
                          
                           SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            Text(TextNames.username,style: AppTextStyle.settingusername),
                            Text(TextNames.userid,style: AppTextStyle.timedate),
                        
                           
                            ]),
                            Spacer(),
                             
                             MenuGlass(),
                             
                     SizedBox(width: 12,),  
                   ],
                   
                    ),
                    const SizedBox(height: 35,),
                    Container(
                      height: 0.4,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10,),
                    const Text(TextNames.settings,style: AppTextStyle.setting),
                    const SizedBox(height: 35,),
                    
                    const Text(TextNames.changeusername,style: AppTextStyle.clickOn),
                    const SizedBox(height: 10,),
                    const Text(TextNames.fontchange,style: AppTextStyle.clickOn),
                    const SizedBox(height: 10,),
                    const Text(TextNames.textcolorchange,style: AppTextStyle.clickOn),
                  ],
                  ),
                ),
            ),
             
            ],
          ),]
        ),
      ),
    );
  }
}