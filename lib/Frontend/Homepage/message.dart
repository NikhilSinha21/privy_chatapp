import 'package:Privy/Frontend/Profile/Userprofile/settingbuttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:url_launcher/url_launcher.dart';




class Message extends StatelessWidget {
  final String text;
  const Message({super.key, required this.text});

  Future<Metadata?> _fetchMeta(String text) async {
    final reg = RegExp(r'(https?:\/\/[^\s]+)');
    final url = reg.firstMatch(text)?.group(0);
    if (url == null) return null;
    try {
      return await MetadataFetch.extract(url);
    } catch (_) {
      return null;
    }
  }

  Future<void> _onOpen(LinkableElement link) async {
    final uri = Uri.parse(link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: messagecontainerColor,
      elevation: 6,
      margin: const EdgeInsets.only(top: 9, right: 25, left: 37),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            FutureBuilder<Metadata?>(
              future: _fetchMeta(text),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox.shrink();
                }
                final data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _previewCard(context, data),
                );
              },
            ),
            SizedBox(height: 10,),
            Linkify(
              text: text,
              onOpen: _onOpen,
              style: AppTextStyle.message,
              linkStyle: const TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _previewCard(BuildContext ctx, Metadata data) {
    return GestureDetector(
      onTap: () async {
        final url = data.url ?? '';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: MediaQuery.of(ctx).size.width * 0.65,
        decoration: BoxDecoration(
          color: Colors.black26.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.image != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  data.image!,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.title != null)
                    Text(
                      data.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (data.description != null)
                    Text(
                      data.description!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (data.url != null)
                    Text(
                      Uri.parse(data.url!).host,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
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
  final Timestamp date;
  const Date({super.key,required this.date} );
  @override
  State<Date> createState() => _Date();
}

class _Date extends State<Date>{
  @override
  Widget build(BuildContext context) {
    final date = widget.date.toDate();
    final formateddate = DateFormat('dd-MM-yyyy').format(date);


    
    return Settingbuttons.textsupportcolor(formateddate,10,Colors.white,FontWeight.w400);
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


