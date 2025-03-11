import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 70, bottom: 30, right: 20, left: 20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/chat.png',
                width: 120,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 40),
              ListTile(
                title: const Text('H O M E'),
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[600],
                ),
              ),
              ListTile(
                onTap: () {
                  context.go('/settings_screen');
                },
                title: const Text('S E T T I N G S'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  context.go('/');
                },
                title: const Text('L O G O U T'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
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
                      context.go(
                        '/chat_screen',
                        extra: users[index],
                      );
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
                              style: Theme.of(context).textTheme.bodyMedium,
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
