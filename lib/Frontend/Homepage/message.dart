
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

class Message extends StatefulWidget {
  const Message({super.key,});
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message>{
  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 8,
      color: messagecontainerColor,
      margin: const EdgeInsets.only(top: 15,right: 30,left: 22),
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),      // no radius
          topRight: Radius.circular(16),    // rounded
          bottomLeft: Radius.circular(16),  // rounded
          bottomRight: Radius.circular(16), // rounded).bottomLeft,
      ),),

      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(TextNames.text,
        style: AppTextStyle.message,),
      )
    );
  }

}


class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key,});
  @override
  State<UserAvatar> createState() => _UserAvatar();
}

class _UserAvatar extends State<UserAvatar>{
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 29,
      backgroundImage: AssetImage("assets/images/user_logo.png"),
    );
  }

}



class UserName extends StatefulWidget {
  const UserName({super.key,});
  @override
  State<UserName> createState() => _UserName();
}

class _UserName extends State<UserName>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: const Text(
        TextNames.username,
        style: AppTextStyle.username,
      ),
    );
  }

}


class Time extends StatefulWidget {
  const Time({super.key,});
  @override
  State<Time> createState() => _Time();
}

class _Time extends State<Time>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      TextNames.time,
      style: AppTextStyle.timedate,
    );
  }

}

class Date extends StatefulWidget {
  const Date({super.key,});
  @override
  State<Date> createState() => _Date();
}

class _Date extends State<Date>{
  @override
  Widget build(BuildContext context) {
    return const Text(
      TextNames.date,
      style: AppTextStyle.timedate,
    );
  }

}




class Reaction extends StatefulWidget {
  const Reaction({super.key,});
  @override
  State<Reaction> createState() => _Reaction();
}

class _Reaction extends State<Reaction>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Container(
          
          decoration: BoxDecoration(
            color: rectioncolor,
            borderRadius: BorderRadius.circular(50)
          ),
          padding: const EdgeInsets.all(10),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Text(TextNames.reaction,
              style: AppTextStyle.reaction,),
              SizedBox(width: 5,),
              Text(TextNames.reactionno,
              style: AppTextStyle.reaction,),
            ],
          ),
        ),
      ],
    );
  }

}


