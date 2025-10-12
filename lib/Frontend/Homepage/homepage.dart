import 'package:Privy/Frontend/Homepage/edittextmessage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Backend/post_service.dart';
import 'package:flutter/services.dart';
import 'package:Privy/Frontend/Homepage/logos.dart';
import 'package:Privy/Frontend/Homepage/message.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:Privy/Frontend/Things/text_names.dart';
import 'package:share_plus/share_plus.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final PostService _postService = PostService();
    final TextEditingController messageText = TextEditingController();
    

/*
     // Function to show emoji picker on long press
  void showReactionPicker(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: ["😂", "😊", "❤️", "😮", "😢", "👍"].map((emoji) {
              return GestureDetector(
                onTap: () async {
                  await _postService.addReaction(postId, emoji);
                  Navigator.pop(context);
                },
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 30),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

*/



   // three dot containing copy,edit,report (Thats it for now)

    void threedot(String textToCopy, String postId, String postUid) {
    final currentUid = authService.value.currentUser?.uid;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

      ),
      builder: (_) {
        return Container(
          height: 250,
          padding: const EdgeInsets.only(left: 10,right: 10),
          decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // dash
                Center(
                  child: Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // COPY BUTTON 
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: textToCopy));
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Copied to clipboard"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const CopyLogo(),
                        ),
                        const SizedBox(height: 5,),
                        const Text("Copy",style: AppTextStyle.Iconnames)
                      ],
                    ),

                    // DELETE BUTTON 
                    if (currentUid == postUid)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: messagecontainerColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: const Text(
                                      "Delete message?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: const Text(
                                      "Are you sure you want to delete this message?",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                                      ),
                                    ],
                                  );
                                },
                              );
                          
                              if (confirm == true) {
                                await _postService.deletePost(postId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Message deleted"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: const DeleteLogo(),
                          ),
                          const SizedBox(height: 5,),
                          const Text("Delete",style: AppTextStyle.Iconnames,)
                        ],
                      ),

                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // close current bottom sheet first
                              //Sharemessage.show(context);
                              Share.share(textToCopy);
                            },
                            child: const ShareLogo()),
                          const SizedBox(height: 5,)
,                          const Text("Share",style: AppTextStyle.Iconnames,)
                        ],
                      ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(color: messagecontainerColor),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    final currentUid = authService.value.currentUser?.uid;
                    Edittextmessage(context, postId, textToCopy, postUid, currentUid ?? "");
                  },
                  child: const Text("Edit", style: AppTextStyle.edit)),
                const SizedBox(height: 10),
                const Text("Report", style: AppTextStyle.report),
              ],
            ),
          ),
        );
      },
    );
  }


    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          // here i want to put the background() so it doesn't change and went back to behind
          //
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
              
                
                padding: const EdgeInsets.only(
                    top: 10, left: 23, right: 23, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppName.appname,
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed((context), '/userprofile');
                      },
                      child: const UserAvatarforgoingtosetting(),
                    )
                  ],
                ),
              ),
             const Divider(color: messagecontainerColor,),
              Expanded(
                
                child: StreamBuilder(
                    stream: _postService.getposts(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child:CircularProgressIndicator());
                      }
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            // values has been defined here 
                            final postDoc = docs[index];
                            final post = docs[index].data() as Map<String, dynamic>;
                            final username = post["username"] ?? "Unknown";
                            final time = post["timestamp"] ?? 00 ;
                            final postId = postDoc.id;
                            final text = post["text"] ?? "";
                            final postUid = post["senderId"] ?? "";


                            return Container(
                              margin: const EdgeInsets.only(bottom: 15,top: 15,left: 20,right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                                                    
                                                                    
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, right: 10),
                                          child: const UserAvatar()),
                                      Sendersname(sendersname: username),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                                                    
                                                                    
                                      const Spacer(),
                                                                    
                                      
                                      GestureDetector(
                                        onTap: () {
                                          threedot(text,postId,postUid);
                                          
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 20, right: 10),
                                          child: Image.asset(
                                            "assets/images/Threedot.png",
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                   GestureDetector(
                                    onLongPress: () { 
                                     // showReactionPicker(context, postId);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Message(text: post["text"] ?? ""),
                                          
                              
                                          Positioned(
                                                right: 40,
                                                bottom: 3,
                                                child: Time(time: time,)),
                                          
                                          Positioned(
                                            left: 50, // moves it to the left
                                            bottom:
                                                -20, // you can adjust vertical position
                                            child: StreamBuilder<QuerySnapshot>(
                                              
                                              stream: _postService.getreaction(postId),
                                              builder:(context, snapshot){
                                                if(snapshot.connectionState == ConnectionState.waiting){
                                                return const SizedBox.shrink(); 
                                                }
                                                if(!snapshot.hasData||snapshot.data!.docs.isEmpty){
                                                  return const SizedBox.shrink();
                                                }
                                                final reactionsDocs = snapshot.data!.docs;
                                      
                                                Map<String, int> reactionCounts = {};
                                                for (var doc in reactionsDocs) {
                                                  final reactionData = doc.data() as Map<String, dynamic>;
                                                  final emoji = reactionData["emoji"] as String;
                                                  reactionCounts[emoji] = (reactionCounts[emoji] ?? 0) + 1;
                                                }
                                                final sortedReactions = reactionCounts.entries.toList()
                                                      ..sort((a, b) => b.value.compareTo(a.value));
                                                
                                                final topTwo = sortedReactions.take(2).toList();
                                                
                                                final otherCount = sortedReactions.skip(2)
                                                .map((e) => e.value)
                                                .fold(0, (sum, count) => sum + count);
                                    
                                                 Map<String, int> displayReactions = {};
                                                 
                                                 for (var entry in topTwo) {
                                                  displayReactions[entry.key] = entry.value;
                                                 }
                                                 if (otherCount > 0) {
                                                displayReactions["+"] = otherCount;
                                                 }
                                                return Reaction(reactionCounts: displayReactions);
                                              }
                                              
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                 
                                ],
                              ),
          
                            );
                            
                          });
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3, top: 3),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        controller: messageText,
                        style: const TextStyle(color: textcolor),
                        decoration: InputDecoration(
                          
                          hintText: TextNames.messagehint,
                          filled: true,
                          fillColor: messagecontainerColor,
                          hintStyle: AppTextStyle.hint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 25,right: 25,bottom: 9),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                       
                      onTap: () async {
                        final text = messageText.text.trim();
                        final uid = authService.value.currentUser?.uid;
                        if(text.isNotEmpty && uid != null){
                          await _postService.createPost(text);
                          messageText.clear();
                        }
                      },
                      child: Image.asset(
                        "assets/images/forward.png",
                        height: 40,
                        width: 40,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}