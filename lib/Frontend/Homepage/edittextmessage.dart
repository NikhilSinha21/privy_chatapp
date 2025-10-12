import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> Edittextmessage(
  BuildContext context,
  String postId,
  String currentText,
  String postUid,
  String currentUid,
) async {
  if (postUid != currentUid) {
    // Not allowed to edit others’ messages
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You can’t edit others’ messages")),
    );
    return;
  }

  final TextEditingController editController =
      TextEditingController(text: currentText);

  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Edit Message", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: editController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Edit your message",
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white38),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onSubmitted: (_) => Navigator.pop(context, true), // Enter key confirms
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm", style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    final newText = editController.text.trim();
    if (newText.isNotEmpty && newText != currentText) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'text': newText});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message updated")),
      );
    }
  }
}
