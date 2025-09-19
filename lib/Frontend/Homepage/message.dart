
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
      color: const Color.fromARGB(255, 32, 32, 32),
      margin: const EdgeInsets.all(15),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(TextNames.text,
            style: AppTextStyle.username,),
          ),

          const Reaction(),
        ],
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
    return const  CircleAvatar(
      radius: 29,
      child: Icon(Icons.person),
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
    return const Text(
      TextNames.username,
      style: AppTextStyle.username,
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
      style: AppTextStyle.clickOn,
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
      style: AppTextStyle.clickOn,
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
        
        Card(

      elevation: 8,
      color: const Color.fromARGB(255, 71, 71, 71),
      margin: const EdgeInsets.all(15),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),

      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(TextNames.reaction,
            style: AppTextStyle.reaction,),
            SizedBox(width: 2,),
            Text(TextNames.reactionno,
            style: AppTextStyle.reaction,),
          ],
        ),
      )
    ),
      ],
    );
  }

}


