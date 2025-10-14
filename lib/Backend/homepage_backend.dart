import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Backend/post_service.dart';
import 'package:Privy/Frontend/Homepage/edittextmessage.dart';
import 'package:Privy/Frontend/Homepage/logos.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class HomepageBackend {
  final PostService _postService = PostService();
  void threedot(BuildContext context,String textToCopy, String postId, String postUid) {
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

}


