import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:privy_chat_chat_app/Backend/auth_service.dart';
import 'package:privy_chat_chat_app/Backend/post_service.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/background.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/message.dart';
import 'package:privy_chat_chat_app/Frontend/Things/app_text_style.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';
import 'package:privy_chat_chat_app/Frontend/Things/text_names.dart';

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




    return Scaffold(
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
                    margin: const EdgeInsets.only(
                        top: 10, left: 23, right: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          TextNames.appname,
                          style: AppTextStyle.appname,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed((context), '/userprofile');
                          },
                          child: Container(
                              padding: const EdgeInsets.only(top: 5, right: 30),
                              child: const UserAvatar()),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: StreamBuilder(
                        stream: _postService.getposts(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text("No posts yet",
                                    style: TextStyle(color: Colors.white)));
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
                                
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, right: 10),
                                              child: const UserAvatar()),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  
                                                  UserName(username: username),
                                                  Time(time: time,),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, right: 10),
                                            child: Image.asset(
                                              "assets/images/Threedot.png",
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                     GestureDetector(
                                      onLongPress: () { 
                                        showReactionPicker(context, postId);
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Message(text: post["text"] ?? ""),
                                            Positioned(
                                              left: 40, // moves it to the left
                                              bottom:
                                                  -22, // you can adjust vertical position
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
                                    const SizedBox(
                                      height: 25,
                                    )
                                  ],
                                );
                              });
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 2, top: 10),
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
                            decoration: InputDecoration(
                              hintText: TextNames.messagehint,
                              filled: true,
                              fillColor: messagecontainerColor,
                              hintStyle: AppTextStyle.hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
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
            ],
          ),
        ),
      ),
    );
  }
}