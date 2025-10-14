import 'package:Privy/Backend/homepage_backend.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Backend/post_service.dart';
import 'package:Privy/Frontend/Homepage/message.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:Privy/Frontend/Things/text_names.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  final PostService _postService = PostService();
  final TextEditingController messageText = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    messageText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.only(top: 10, left: 23, right: 23, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppName.appname,
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/userprofile');
                      },
                      child: const UserAvatar(),
                    )
                  ],
                ),
              ),
              const Divider(color: messagecontainerColor),

              // Messages Stream
              Expanded(
                child: StreamBuilder(
                  stream: _postService.getposts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    // Scroll to bottom automatically on new messages
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final postDoc = docs[index];
                        final post = docs[index].data() as Map<String, dynamic>;
                        final username = post["username"] ?? "Unknown";
                        final time = post["timestamp"] as Timestamp;
                        final postId = postDoc.id;
                        final text = post["text"] ?? "";
                        final postUid = post["senderId"] ?? "";

                        // 🗓 Show date separator if new date
                        bool showdate = false;
                        final currentDate = time.toDate();
                        final formattedCurrent = DateFormat('dd-MM-yyyy').format(currentDate);
                        if (index == 0) {
                          showdate = true;
                        } else {
                          final prevPost = docs[index - 1].data() as Map<String, dynamic>;
                          final prevTime = prevPost["timestamp"] as Timestamp;
                          final prevDate = prevTime.toDate();
                          final formattedPrev = DateFormat('dd-MM-yyyy').format(prevDate);
                          if (formattedPrev != formattedCurrent) {
                            showdate = true;
                          }
                        }

                        //  Show sender if different user or new day
                        bool showsender = false;
                        if (index == 0) {
                          showsender = true;
                        } else {
                          final prevPost = docs[index - 1].data() as Map<String, dynamic>;
                          final prevUid = prevPost["senderId"] ?? "";
                          final prevTime = prevPost["timestamp"] as Timestamp;
                          final prevDate = prevTime.toDate();
                          final formattedPrev = DateFormat('dd-MM-yyyy').format(prevDate);
                          if (prevUid != postUid || formattedPrev != formattedCurrent) {
                            showsender = true;
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 2, left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showdate)
                                Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 3),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: messagecontainerColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Date(date: time),
                                    ),
                                  ),
                                ),

                              if (showsender)
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 5, right: 10),
                                        child: const UserAvatar(),
                                      ),
                                      Sendersname(sendersname: username),
                                    ],
                                  ),
                                ),

                              //  Message bubble
                              Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onLongPress: () {
                                    final homepagebackend = HomepageBackend();
                                    homepagebackend.threedot(context, text, postId, postUid);
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Message(text: text),
                                      Positioned(
                                        right: 40,
                                        bottom: 2,
                                        child: Time(time: time),
                                      ),
                                      Positioned(
                                        left: 50,
                                        bottom: -20,
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: _postService.getreaction(postId),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const SizedBox.shrink();
                                            }
                                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              //  Message Input
              Container(
                margin: const EdgeInsets.only(bottom: 3, top: 3),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
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
                          contentPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 9),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () async {
                        final text = messageText.text.trim();
                        final uid = authService.value.currentUser?.uid;
                        if (text.isNotEmpty && uid != null) {
                          await _postService.createPost(text);
                          messageText.clear();
                        }
                      },
                      child: Image.asset(
                        "assets/images/forward.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
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
