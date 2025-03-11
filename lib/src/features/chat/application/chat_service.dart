import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_service.g.dart';

class ChatService {
  ChatService(this._ref);
  final Ref _ref;

  Stream<QuerySnapshot> getMessages(String roomID) {
    return _ref.read(chatRepositoryProvider).getMessages(roomID);
  }

  String generateRoomId(String currentUserID, String otherUserID) {
    List<String> ids = [
      currentUserID.toLowerCase().trim(),
      otherUserID.toLowerCase().trim()
    ];
    ids.sort();
    return ids.join('_');
  }
}

@riverpod
ChatService chatService(Ref ref) {
  return ChatService(ref);
}
