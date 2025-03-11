import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({
    super.key,
    required this.otherUserEmail,
    required this.roomID,
  });

  final String otherUserEmail;
  final String roomID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness brightness = Theme.of(context).brightness;
    final chatService = ref.watch(chatServiceProvider);

    bool isDarkMode = brightness == Brightness.dark;

    return StreamBuilder(
      stream: chatService.getMessages(roomID),
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
          ),
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var message = docs[index]['content'];
            var userId = docs[index]['senderID'];

            bool isMe = FirebaseAuth.instance.currentUser!.uid == userId;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? isMe
                          ? Colors.green
                          : Colors.grey[800]
                      : isMe
                          ? Colors.green
                          : Colors.white,
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
                  style: isDarkMode
                      ? GoogleFonts.roboto(
                          color: Colors.white,
                        )
                      : GoogleFonts.roboto(
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
