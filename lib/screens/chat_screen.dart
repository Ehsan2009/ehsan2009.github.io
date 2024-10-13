import 'package:chat_app/components/chat_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String roomId;
  var messageController = TextEditingController();
  bool isAuthenticating = false;

  String generateRoomId(String? userId1, String userId2) {
    List<String> ids = [
      userId1!.toLowerCase().trim(),
      userId2.toLowerCase().trim()
    ];
    ids.sort();
    return ids.join('_');
  }

  void sendMessage(String roomId, String message, String senderId) async {
    setState(() {
      isAuthenticating = true;
    });

    await FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .add({
      'message': message,
      'senderId': senderId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();

    setState(() {
      isAuthenticating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    roomId = generateRoomId(
      FirebaseAuth.instance.currentUser!.email,
      widget.userEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          widget.userEmail,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.go('/home_screen');
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.grey[700],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // chat messages
            Expanded(
              child: ChatMessages(
                otherUserEmail: widget.userEmail,
                roomId: roomId,
              ),
            ),

            // sending a new message
            Row(
              children: [
                // message textformfield
                Expanded(
                  child: TextField(
                    controller: messageController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.white54,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // sending button
                FloatingActionButton(
                  onPressed: () {
                    sendMessage(
                      roomId,
                      messageController.text,
                      FirebaseAuth.instance.currentUser!.uid,
                    );
                  },
                  elevation: 0,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.green,
                  child: isAuthenticating
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.arrow_upward_outlined,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
