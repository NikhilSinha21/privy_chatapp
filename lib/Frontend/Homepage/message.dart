
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:Privy/Frontend/Things/text_names.dart';

class Message extends StatefulWidget {
  final String text; // add this
  const Message({super.key, required this.text});
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message>{

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 8,
      color: messagecontainerColor,
      margin: const EdgeInsets.only(top: 9,right: 25,left: 37,),
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),      // no radius
          topRight: Radius.circular(16),    // rounded
          bottomLeft: Radius.circular(16),  // rounded
          bottomRight: Radius.circular(16), // rounded).bottomLeft,
      ),),

      child: Container(
        padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
        child:  Text(widget.text,
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
      radius: 18,
      backgroundImage: AssetImage("assets/images/user_logo.png"),
    );
  }

}



class UserAvatarforgoingtosetting extends StatelessWidget{
  const UserAvatarforgoingtosetting({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundImage: AssetImage("assets/images/user_logo.png"),
    );
  }

}


class Sendersname extends StatefulWidget {
  final String sendersname ;
  const Sendersname({super.key,required this.sendersname});
  @override
  State<Sendersname> createState() => _Sendersname();
}

class _Sendersname extends State<Sendersname>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        widget.sendersname,
        style: AppTextStyle.sendersname,
      ),
    );
  }

}


class Time extends StatefulWidget {
  final Timestamp time;
  const Time({super.key,required this.time});
  @override
  State<Time> createState() => _Time();
}

class _Time extends State<Time>{
  @override
  Widget build(BuildContext context) {
    final dateTime = widget.time.toDate(); // convert Firestore Timestamp to DateTime
    final formattedTime = DateFormat('hh:mm a').format(dateTime); // e.g., 02:30 PM


    return  Text(
      formattedTime,
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






// Assuming you have imported TextNames, AppTextStyle, and rectioncolor from 'privy_chat_chat_app/Frontend/Things/...'

class Reaction extends StatelessWidget {
  // Correct Parameter: This must match the name used in StreamBuilder (reactionCounts: reactionCounts)
  final Map<String, int> reactionCounts;

  const Reaction({
    super.key,
    required this.reactionCounts,
  });

  @override
  Widget build(BuildContext context) {
    if (reactionCounts.isEmpty) {
      return const SizedBox.shrink(); // Hide the widget if there are no reactions
    }

    // 1. Prepare data: Sort reactions by count (descending) and filter out zero counts
    final reactionsToDisplay = reactionCounts.entries
        .where((e) => e.value > 0)
        .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

    // 2. Build the UI: Use a single container to hold all reactions
    return Container(
      // The overall layout container to give the reaction bubble a background
      
      decoration: BoxDecoration(
        // Assuming rectioncolor is defined and imported
        // Use a lighter color like Colors.white or an imported color
        color: rectioncolor, 
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 132, 132, 132),
          ) 
        //////////////////////////////////////////////////////////////////////////////////
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        
        // 3. Map the reaction entries to a list of widgets
        children: reactionsToDisplay.map((entry) {
          // A Row for each unique reaction type (Emoji + Count)
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the Emoji
                Text(
                  entry.key, // The emoji string
                  // Assuming AppTextStyle.reaction is defined and imported
                  style: AppTextStyle.reaction, 
                ),
                const SizedBox(width: 3),
                // Display the Count
                Text(
                  entry.value.toString(), // The count (e.g., '5')
                  style: AppTextStyle.reactiontext,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


