import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room_controller.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_messages.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  late String roomID;
  var messageController = TextEditingController();

  void sendMessage(Message message) async {
    ref.read(chatRoomControllerProvider.notifier).sendMessage(message);

    messageController.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final chatService = ref.watch(chatServiceProvider);
    roomID = chatService.generateRoomId(
      FirebaseAuth.instance.currentUser!.email!,
      widget.userEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatRoomControllerProvider);
    final currentUser = ref.read(authRepositoryProvider).currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          widget.userEmail,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(AppRoute.chatList.name);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            // chat messages
            Expanded(
              child: ChatMessages(
                otherUserEmail: widget.userEmail,
                roomID: roomID,
              ),
            ),

            // sending a new message
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: messageController,
                      hintText: 'Type a message',
                    ),
                  ),

                  const SizedBox(width: 16),

                  // sending button
                  FloatingActionButton(
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        return;
                      }
                      sendMessage(
                        Message(
                          content: messageController.text,
                          roomID: roomID,
                          senderID: currentUser!.id,
                          timestamp: DateTime.now(),
                        ),
                      );
                    },
                    elevation: 0,
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.white,
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
