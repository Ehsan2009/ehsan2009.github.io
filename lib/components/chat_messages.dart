import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.otherUserEmail,
    required this.roomId,
  });

  final String otherUserEmail;
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('is loading...');
        }

        if (!snapshot.hasData) {
          return const Text('there is not message');
        }

        var docs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 10,
            right: 10,
          ),
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var message = docs[index]['message'];
            var userId = docs[index]['senderId'];

            bool isMe = FirebaseAuth.instance.currentUser!.uid == userId;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isMe ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: !isMe ? Radius.zero : const Radius.circular(12),
                    topRight: isMe ? Radius.zero : const Radius.circular(12),
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                  ),
                ),
                child: Text(
                  message,
                  softWrap: true,
                  style: GoogleFonts.roboto(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
