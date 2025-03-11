import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

class ChatRepository {
  ChatRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> sendMessage(Message message) {
    return _firestore
        .collection('chatRooms')
        .doc(message.roomID)
        .collection('messages')
        .add(message.toJson());
  }

  Stream<QuerySnapshot> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<List<String>> fetchUsersEmail(String currentUserEmail) async {
    List<String> users = [];

    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<DocumentSnapshot> usersDocs = usersSnapshot.docs;

    for (var doc in usersDocs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      String userEmail = data['email'];

      if (userEmail.trim() != currentUserEmail) {
        users.add(userEmail);
      }
    }

    return users;
  }
}

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(FirebaseFirestore.instance);
}
