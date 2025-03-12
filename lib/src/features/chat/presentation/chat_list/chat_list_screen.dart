import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/custom_drawer.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('U S E R S'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: ref.watch(chatServiceProvider).fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      context.goNamed(AppRoute.chatRoom.name,
                          pathParameters: {'userEmail': users[index]});
                    },
                    child: Card(
                      color: Theme.of(context).cardTheme.color,
                      elevation: 20,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 16),
                            Text(
                              users[index],
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('No users available'));
        },
      ),
    );
  }
}
