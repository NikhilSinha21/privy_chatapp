import 'package:Privy/Backend/homepage_backend.dart';
import 'package:Privy/Backend/presence_server.dart';
import 'package:Privy/Frontend/Homepage/logos.dart';
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

class HomepageNew extends StatefulWidget {
  const HomepageNew({super.key});

  @override
  State<HomepageNew> createState() => _HomepageNewState();
}

class _HomepageNewState extends State<HomepageNew> {
  late Map<String, dynamic> config;
  late String welcomeText;
  late Color bgColor;
  late Color divider;
  late Color messagebackgroundColor2;
  late Color arrow_downward;

  final ScrollController _scrollController = ScrollController();
  final PostService _postService = PostService();
  final TextEditingController messageText = TextEditingController();
  
    @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      config = args;
      final bgColorHex = config['backgroundColor'] ?? '#000000';
      bgColor = Color(int.parse(bgColorHex.replaceFirst('#', '0xff')));
      final dividerHex = config['divider']?? '#373737';
      divider = Color(int.parse(dividerHex.replaceFirst('#', '0xff')));
      final messagebackgroundColor2Hex = config['messagebackgroundColor']?? '#373737';
      messagebackgroundColor2 = Color(int.parse(messagebackgroundColor2Hex.replaceFirst('#', '0xff')));
      final arrowdownwardHex = config['arrow_downward'] ?? '#000000';
      arrow_downward = Color(int.parse(arrowdownwardHex.replaceFirst('#', '0xff')));
    } else {
      welcomeText = 'Hello!';
      bgColor = Colors.black;
    }
  }

  
  @override
  void dispose() {
    _scrollController.dispose();
    messageText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header Section
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 23, right: 23, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppName.appname,
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/userprofile'),
                    child: const UserAvatar(radius: 16),
                  ),
                ],
              ),
            ),

            Divider(color: divider),

            //Messages Stream
            Expanded(
              child: Stack(
                children: [
                  Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    thickness: 5,
                    radius: const Radius.circular(20),
                    child: StreamBuilder(
                      stream: _postService.getposts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                    
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              "No messages yet...",
                              style: TextStyle(color: Color.fromARGB(255, 174, 174, 174)),
                            ),
                          );
                        }
                    
                        final docs = snapshot.data!.docs;
                    
                        // Scroll to bottom after new messages
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
                            final post = postDoc.data() as Map<String, dynamic>;
                            final username = post["username"] ?? "Unknown";
                            final time = post["timestamp"] as Timestamp;
                            final postId = postDoc.id;
                            final text = post["text"] ?? "";
                            final postUid = post["senderId"] ?? "";
                    
                            // Date Separator Logic
                            bool showDate = false;
                            final currentDate = time.toDate();
                            final formattedCurrent =
                                DateFormat('dd-MM-yyyy').format(currentDate);
                    
                            if (index == 0) {
                              showDate = true;
                            } else {
                              final prevPost =
                                  docs[index - 1].data() as Map<String, dynamic>;
                              final prevTime = prevPost["timestamp"] as Timestamp;
                              final prevDate = prevTime.toDate();
                              final formattedPrev =
                                  DateFormat('dd-MM-yyyy').format(prevDate);
                              if (formattedPrev != formattedCurrent) {
                                showDate = true;
                              }
                            }
                    
                            //  Sender Display Logic
                            bool showSender = false;
                            if (index == 0) {
                              showSender = true;
                            } else {
                              final prevPost =
                                  docs[index - 1].data() as Map<String, dynamic>;
                              final prevUid = prevPost["senderId"] ?? "";
                              final prevTime = prevPost["timestamp"] as Timestamp;
                              final prevDate = prevTime.toDate();
                              final formattedPrev =
                                  DateFormat('dd-MM-yyyy').format(prevDate);
                              if (prevUid != postUid ||
                                  formattedPrev != formattedCurrent) {
                                showSender = true;
                              }
                            }
                    
                            return Container(
                              margin: const EdgeInsets.only(
                                  bottom: 6, top: 2, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (showDate)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10, bottom: 3),
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: messagebackgroundColor2,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Date(date: time),
                                        ),
                                      ),
                                    ),
                    
                                  if (showSender)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, right: 10),
                                            child: StreamBuilder<bool>(
                                              stream: PresenceServer()
                                                  .userOnlineStatus(postUid),
                                              builder: (context, snapshot) {
                                                final isOnline =
                                                    snapshot.data ?? false;
                                                return UserAvatar(
                                                    isOnline: isOnline, radius: 16);
                                              },
                                            ),
                                          ),
                                          Sendersname(sendersname: username),
                                        ],
                                      ),
                                    ),
                    
                                  // Message bubble with reaction & time
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        HomepageBackend().threedot(
                                            context, text, postId, postUid);
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
                                              stream:
                                                  _postService.getreaction(postId),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const SizedBox.shrink();
                                                }
                    
                                                if (!snapshot.hasData ||
                                                    snapshot.data!.docs.isEmpty) {
                                                  return const SizedBox.shrink();
                                                }
                    
                                                final reactionsDocs =
                                                    snapshot.data!.docs;
                                                Map<String, int> reactionCounts = {};
                    
                                                for (var doc in reactionsDocs) {
                                                  final data = doc.data()
                                                      as Map<String, dynamic>;
                                                  final emoji =
                                                      data["emoji"] as String;
                                                  reactionCounts[emoji] =
                                                      (reactionCounts[emoji] ?? 0) +
                                                          1;
                                                }
                    
                                                final sorted = reactionCounts.entries
                                                    .toList()
                                                  ..sort((a, b) =>
                                                      b.value.compareTo(a.value));
                    
                                                final topTwo =
                                                    sorted.take(2).toList();
                                                final otherCount = sorted
                                                    .skip(2)
                                                    .map((e) => e.value)
                                                    .fold(0, (a, b) => a + b);
                    
                                                Map<String, int> display = {};
                                                for (var entry in topTwo) {
                                                  display[entry.key] = entry.value;
                                                }
                                                if (otherCount > 0) {
                                                  display["+"] = otherCount;
                                                }
                    
                                                return Reaction(
                                                    reactionCounts: display);
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
             
                   Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
                        if(_scrollController.hasClients){
                          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 20), curve: Curves.easeOut);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: messagebackgroundColor2,
                                    child:  Icon(
                                      Icons.arrow_downward,
                                      color: arrow_downward,
                                      size: 30,
                                    ),
                                  ),
                    ),
                  ),
                ],
              ),
            ),
            

            // Message Input
            Container(
              margin: const EdgeInsets.only(bottom: 3, top: 3),
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 2,
                      controller: messageText,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(color: textcolor),
                      decoration: InputDecoration(
                        hintText: TextNames.messagehint,
                        filled: true,
                        fillColor: messagebackgroundColor2,
                        hintStyle: AppTextStyle.hint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 9),
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
    );
  }
}
